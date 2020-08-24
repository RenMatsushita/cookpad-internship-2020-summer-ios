final class RecipeDetailsPresenter: RecipeDetailsPresenterProtocol {
    private weak var view: RecipeDetailsViewProtocol!
    private let interactor: RecipeDetailsInteractorProtocol
    private let wireframe: RecipeDetailsWireframeProtocol
    private var recipeId: String!
    init(recipeId: String, view: RecipeDetailsViewProtocol, interactor: RecipeDetailsInteractorProtocol, wireframe: RecipeDetailsWireframeProtocol) {
        self.recipeId = recipeId
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        interactor.fetchRecipeDetailsBy(id: self.recipeId) { [weak self] result in
            switch result {
            case let .success(recipeDetails):
                self?.view.showRecipe(with: recipeDetails)
                break
            case let .failure(error):
                self?.view.showError(with: error)
                break
            }
        }
    }
    
    func popPreviousViewController() {
        wireframe.popPreviousViewController()
    }
}
