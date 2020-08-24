protocol RecipeDetailsViewProtocol: AnyObject {
    func showRecipe(with recipeDetails: RecipeDetails)
    func showError(with error: Error)
}

protocol RecipeDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func popPreviousViewController()
}

protocol RecipeDetailsInteractorProtocol: AnyObject {
    func fetchRecipeDetailsBy(id: String, completion: @escaping((Result<RecipeDetails, Error>) -> Void))
}

protocol RecipeDetailsWireframeProtocol: AnyObject {
    func popPreviousViewController()
}
