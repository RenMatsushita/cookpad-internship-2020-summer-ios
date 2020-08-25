//
//  RecipeEditorInteractor.swift
//  MiniCookpad
//
//  Created by Ren Matsushita on 2020/08/24.
//  Copyright © 2020 kensuke-hoshikawa. All rights reserved.
//

import UIKit

final class RecipeEditorInteractor: RecipeEditorInteractorProtocol {
    private let recipeDataStore: RecipeDataStoreProtocol
    init(recipeDataStore: RecipeDataStoreProtocol) {
        self.recipeDataStore = recipeDataStore
    }
    
    func validate(title: String?, steps: [String?], image: UIImage?) -> Bool {
        guard let title = title else { return false }
        if title.count == 0 { return false }
        if steps.count == 0 {
            return false
        }
        for step in steps {
            if let step = step {
                print(step)
                if step.containsEmoji() {
                    print(step, true)
                    return false
                }
            }
        }
        if image == nil {
            return false
        }
        return true
    }
    
    func createRecipe(title: String, steps: [String], image: UIImage, complation: @escaping ((Result<Void, Error>)) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        recipeDataStore.setImage(imageData: imageData) { setImageResult in
            switch setImageResult {
            case let .success(imageFileName):
                self.recipeDataStore.createRecipe(withRecipe: FirestoreRecipe(title: title, imagePath: imageFileName, steps: steps)) { createRecipeResult in
                    switch createRecipeResult {
                    case .success:
                        complation(.success(()))
                    case let .failure(error):
                        complation(.failure(error))
                    }
                }
            case let .failure(error):
                complation(.failure(error))
            }
        }
    }
}

extension String {
    func containsEmoji() -> Bool {
        print(self)
        var surrogatePairCharacters: [Character] {
            return self.filter { String($0).utf16.count > 1 }.reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
        }
        return !surrogatePairCharacters.isEmpty
    }
}
