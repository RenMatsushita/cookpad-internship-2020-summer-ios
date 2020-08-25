import Firebase

protocol RecipeDataStoreProtocol {
    func fetchAllRecipes(completion: @escaping ((Result<[FirestoreRecipe], Error>) -> Void))
    func fetchRecipeDetailsBy(id: String, completion: @escaping ((Result<FirestoreRecipeDetails, Error>)) -> Void)
    func createRecipe(withRecipe recipe: FirestoreRecipe, completion: @escaping ((Result<Void, Error>)) -> Void)
     func setImage(imageData: Data, completion: @escaping ((Result<String, Error>)) -> Void)
}

struct RecipeDataStore: RecipeDataStoreProtocol {
    private let collection: CollectionReference

    init(db: Firestore = Firestore.firestore()) {
        self.collection = db.collection("recipes")
    }

    func fetchAllRecipes(completion: @escaping ((Result<[FirestoreRecipe], Error>) -> Void)) {
        collection.order(by: "createdAt", descending: true).getDocuments() { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let recipe = querySnapshot!.documents
                    // 取得したデータを FirestoreRecipe に変換
                    // Ren: ここ、try?が失敗してnilに入る場合はアプリ的にかなり致命的なエラーなので!で落としてもいいのではと感じた
                    // mapで代替してそのままclosureに.successで渡しても良さそう <- 好み
                    .compactMap { try? $0.data(as: FirestoreRecipe.self)  }
                completion(.success(recipe))
            }
        }
    }
    
    func fetchRecipeDetailsBy(id: String, completion: @escaping ((Result<FirestoreRecipeDetails, Error>)) -> Void) {
        collection.document(id).getDocument() { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let recipeDetials = try? snapshot?.data(as: FirestoreRecipeDetails.self) else {
                    completion(.failure(AppError()))
                    return
                }
                completion(.success(recipeDetials))
            }
        }
    }
    
    func createRecipe(withRecipe recipe: FirestoreRecipe, completion: @escaping ((Result<Void, Error>)) -> Void) {
        _ = try! collection.addDocument(from: recipe) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    /// FB Storageに画像を保存する
    /// - Parameters:
    ///   - imageData: 保存したい画像のData
    ///   - completion: successの場合、ランダムに生成したfileNameがStringでかえる
    func setImage(imageData: Data, completion: @escaping ((Result<String, Error>)) -> Void) {
        let storageReference = Storage.storage().reference()
        let fileName = "\(UUID()).jpg"
        let imageRef = storageReference.child(fileName)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        _ = imageRef.putData(imageData, metadata: metaData) { metadata, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success((fileName)))
            }
        }
    }
}
