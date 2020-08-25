//
//  RecipeEditorPresenter.swift
//  MiniCookpad
//
//  Created by Ren Matsushita on 2020/08/25.
//  Copyright © 2020 kensuke-hoshikawa. All rights reserved.
//

import UIKit

final class RecipeEditorPresenter: RecipeEditorPresenterProtocol {
    private weak var view: RecipeEditorViewProtocol!
    private let interactor: RecipeEditorInteractorProtocol
    private let wireframe: RecipeEditorWireframeProtocol
    init(view: RecipeEditorViewProtocol, interactor: RecipeEditorInteractorProtocol, wireframe: RecipeEditorWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func didTapPost(title: String?, steps: [String?], image: UIImage?) {
        if interactor.validate(title: title, steps: steps, image: image) {
            interactor.createRecipe(
                title: title!,
                steps: steps as! [String],
                image: image!) { [weak self] result in
                    switch result {
                    case .success:
                        self?.view.showComplete()
                    case let .failure(error):
                        self?.view.showError(wirh: error)
                    }
            }
        } else {
            view.showValidationError()
        }
    }
    
    func dismiss() {
        wireframe.dismiss()
    }
}
