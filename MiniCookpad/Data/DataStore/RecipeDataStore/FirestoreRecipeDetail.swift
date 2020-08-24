//
//  FirestoreRecipeDetail.swift
//  MiniCookpad
//
//  Created by Ren Matsushita on 2020/08/24.
//  Copyright © 2020 kensuke-hoshikawa. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct FirestoreRecipeDetails: Codable, Equatable {
    @DocumentID var id: String?
    var title: String
    var imagePath: String
    var steps: [String]
    var createdAt = Date()
}
