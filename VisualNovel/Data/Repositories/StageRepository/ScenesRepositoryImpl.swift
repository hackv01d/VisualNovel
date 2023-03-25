//
//  ScenesRepositoryImpl.swift.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class ScenesRepositoryImplementation: ScenesRepository {
    
    private var scenes: [Scene] = []
    
    private(set) lazy var maxChoicesCount = scenes.reduce(Int.min) { max($0, $1.choices.count) }
    private(set) lazy var minChoicesCount = scenes.reduce(Int.max) { min($0, $1.choices.count) }
    
    init() {
        loadScenes()
    }
    
    func isLastMainScene(sceneId: Int) -> Bool {
        return scenes.last?.id == sceneId
    }
    
    func isStartMainScene(sceneId: Int) -> Bool {
        return scenes.first?.id == sceneId
    }
    
    func getScene(for sceneId: Int, completion: (Result<Scene, ScenesRepositoryError>) -> Void) {
        if let scene = scenes.first(where: { $0.id == sceneId }) {
            completion(.success(scene))
        } else {
            completion(.failure(ScenesRepositoryError.failedReceiptScene))
        }
    }
    
    func updateWelcomeScene(with sceneId: Int, userName: String?) {
        guard let indexScene = scenes.firstIndex(where: { $0.id == sceneId }) else { return }
        guard let newUserName = userName?.trimmingCharacters(in: .whitespaces) else { return }
        
        var scene = scenes[indexScene]
        scene.prompt = scene.prompt.replacingOccurrences(of: scene.userName ?? "unknown", with: newUserName)
        scene.userName = newUserName
        scenes[indexScene] = scene
    }
    
    private func loadScenes() {
        let languagePrefix = Locale.preferredLanguages[0].prefix(2)
        guard let path = getJsonFilePath(jsonFileName: "scenes_\(languagePrefix)") else { return }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let result = try JSONDecoder().decode(SceneResponse.self, from: data)
            scenes = result.scenes.map { $0.toScene() }
        } catch {
            print(ScenesRepositoryError.failedLoadData)
        }
    }
    
    private func getJsonFilePath(jsonFileName: String) -> String? {
        return Bundle.main.path(forResource: jsonFileName, ofType: "json")
    }
}
