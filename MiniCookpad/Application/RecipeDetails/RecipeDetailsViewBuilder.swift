struct RecipeDetailsViewBuilder {
    static func build(withRecipeId recipeId: String) -> RecipeDetailsViewController {
        let viewController = RecipeDetailsViewController()
        let recipeDataStore = RecipeDataStore()
        let interactor = RecipeDetailsInteractor(recipeDataStore: recipeDataStore)
        let wireframe = RecipeDetailsWireframe(viewController: viewController)
        let presenter = RecipeDetailsPresenter(recipeId: recipeId, view: viewController, interactor: interactor, wireframe: wireframe)
        viewController.inject(presenter: presenter)

        return viewController
    }
}
