//
//  RecipeEditorInteractorTests.swift
//  MiniCookpadTests
//
//  Created by Ren Matsushita on 2020/08/25.
//  Copyright © 2020 kensuke-hoshikawa. All rights reserved.
//

import XCTest
@testable import MiniCookpad

class MockRecipeDataStore: RecipeDataStoreProtocol {
    var createRecipeResult: Result<Void, Error>!
    var setImageResult: Result<String, Error>!
    
    func fetchAllRecipes(completion: @escaping ((Result<[FirestoreRecipe], Error>) -> Void)) {}
    
    func fetchRecipeDetailsBy(id: String, completion: @escaping ((Result<FirestoreRecipeDetails, Error>)) -> Void) { }
    
    func createRecipe(withRecipe recipe: FirestoreRecipe, completion: @escaping ((Result<Void, Error>)) -> Void) {
        completion(createRecipeResult)
    }
    
    func setImage(imageData: Data, completion: @escaping ((Result<String, Error>)) -> Void) {
        completion(setImageResult)
    }
}

class RecipeEditorInteractorTests: XCTestCase {
    let dataStore = MockRecipeDataStore()
    
    override func setUp() {
        super.setUp()
    }
    
    func testValidateNilTitle() {
        let interactor = RecipeEditorInteractor(recipeDataStore: dataStore)
        let validationResult = interactor.validate(title: nil, steps: [""], image: UIImage())
        XCTAssertFalse(validationResult)
    }
}
