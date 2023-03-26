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
    
    private var scenesLoadedError: ScenesRepositoryError?
    
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
        if let scenesLoadedError = scenesLoadedError {
            completion(.failure(scenesLoadedError))
        } else if let scene = scenes.first(where: { $0.id == sceneId }) {
            completion(.success(scene))
        } else {
            completion(.failure(ScenesRepositoryError.failedToReceiveScene))
        }
    }
    
    func updateWelcomeScene(with sceneId: Int, username: String?) {
        guard let indexScene = scenes.firstIndex(where: { $0.id == sceneId }) else { return }
        guard let newUsername = username?.trimmingCharacters(in: .whitespaces) else { return }
        
        var scene = scenes[indexScene]
        scene.prompt = scene.prompt.replacingOccurrences(of: scene.username ?? "unknown", with: newUsername)
        scene.username = newUsername
        scenes[indexScene] = scene
    }
    
    private func loadScenes() {
        let languagePrefix = Locale.preferredLanguages[0].prefix(2)
        
        do {
            guard let path = getJsonFilePath(jsonFileName: "scenes_\(languagePrefix)") else {
                throw ScenesRepositoryError.failedToGetFilePath
            }
            
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                throw ScenesRepositoryError.failedToGetData
            }
            
            guard let result = try? JSONDecoder().decode(SceneResponse.self, from: data) else {
                throw ScenesRepositoryError.failedToParseData
            }
            
            scenes = result.scenes.map { $0.toScene() }
            
        } catch let error as ScenesRepositoryError {
            scenesLoadedError = error
        } catch {
            print("Unknown error occurred")
        }
    }
    
    private func getJsonFilePath(jsonFileName: String) -> String? {
        return Bundle.main.path(forResource: jsonFileName, ofType: "json")
    }
}
