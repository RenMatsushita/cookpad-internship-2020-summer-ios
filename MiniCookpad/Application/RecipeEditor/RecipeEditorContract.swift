import UIKit

protocol RecipeEditorViewProtocol: AnyObject {
    func showValidationError()
    func showError(wirh error: Error)
    func showComplete()
}

protocol RecipeEditorPresenterProtocol: AnyObject {
    func didTapPost(title: String?, steps: [String?], image: UIImage?)
    func dismiss()
}

protocol RecipeEditorInteractorProtocol: AnyObject {
    func validate(title: String?, steps: [String?], image: UIImage?) -> Bool
    func createRecipe(title: String, steps: [String], image: UIImage, complation: @escaping ((Result<Void, Error>)) -> Void)
}

protocol RecipeEditorWireframeProtocol: AnyObject {
    func dismiss()
}
