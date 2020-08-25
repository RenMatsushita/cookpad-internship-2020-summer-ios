//
//  RecipeEditorViewBuilder.swift
//  MiniCookpad
//
//  Created by Ren Matsushita on 2020/08/25.
//  Copyright © 2020 kensuke-hoshikawa. All rights reserved.
//

struct RecipeEditorViewBuilder {
    static func build() -> RecipeEditorViewController {
        let viewController = RecipeEditorViewController()
        let recipeDataStore = RecipeDataStore()
        let interactor = RecipeEditorInteractor(recipeDataStore: recipeDataStore)
        let wireframe = RecipeEditorWireframe(viewController: viewController)
        let presenter = RecipeEditorPresenter(view: viewController, interactor: interactor, wireframe: wireframe)
        viewController.inject(presenter: presenter)

        return viewController
    }
}
