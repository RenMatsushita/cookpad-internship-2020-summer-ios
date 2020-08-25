final class RecipeDetailsInteractor: RecipeDetailsInteractorProtocol {
    private let recipeDataStore: RecipeDataStoreProtocol
    init(recipeDataStore: RecipeDataStoreProtocol) {
        self.recipeDataStore = recipeDataStore
    }
    
    func fetchRecipeDetailsBy(id: String, completion: @escaping ((Result<RecipeDetails, Error>) -> Void)) {
        recipeDataStore.fetchRecipeDetailsBy(id: id) { result in
            switch result {
            case let .success(recipeDetails):
                completion(
                    .success(RecipeDetails(title: recipeDetails.title, imagePath: recipeDetails.imagePath, steps: recipeDetails.steps)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
