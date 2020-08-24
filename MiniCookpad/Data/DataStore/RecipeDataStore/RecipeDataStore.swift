import Firebase

protocol RecipeDataStoreProtocol {
    func fetchAllRecipes(completion: @escaping ((Result<[FirestoreRecipe], Error>) -> Void))
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
}
