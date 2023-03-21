//
//  SceneRepositoryImpl.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation

final class SceneRepositoryImpl {
    
    private var scenes: [Scene] = []
    
    init() {
        loadScenes()
    }
    
    private func getJsonFilePath(jsonFileName: String) -> String? {
        return Bundle.main.path(forResource: jsonFileName, ofType: "json")
    }
    
    private func loadScenes() {
        guard let path = getJsonFilePath(jsonFileName: "scenes") else { return }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let result = try JSONDecoder().decode(SceneResponse.self, from: data)
            scenes = result.scenes.map { $0.toScene() }
        } catch {
            print(SceneRepositoryError.failedLoadData)
        }
    }
}

extension SceneRepositoryImpl: SceneRepository {
    func getScene(for sceneId: Int, completion: (Result<Scene, SceneRepositoryError>) -> Void) {
        if let scene = scenes.first(where: { $0.id == sceneId }) {
            completion(.success(scene))
        } else {
            completion(.failure(SceneRepositoryError.failedReceiptScene))
        }
    }
    
    func updateWelcomeScene(with sceneId: Int, userName: String?) {
        guard let indexScene = scenes.firstIndex(where: { $0.id == sceneId }) else { return }
        guard let newUserName = userName?.replacingOccurrences(of: #"((^\s+)|(\s+$))"#,
                                                               with: "",
                                                               options: .regularExpression) else { return }
        
        var scene = scenes[indexScene]
        scene.prompt = scene.prompt.replacingOccurrences(of: scene.userName ?? "unknown", with: newUserName)
        scene.userName = newUserName
        scenes[indexScene] = scene
    }
}
