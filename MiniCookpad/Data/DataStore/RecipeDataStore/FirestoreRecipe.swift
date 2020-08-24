//
//  FirestoreRecipe.swift
//  MiniCookpad
//
//  Created by kensuke-hoshikawa on 2020/08/20.
//  Copyright © 2020 kensuke-hoshikawa. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct FirestoreRecipe: Codable, Equatable {
    @DocumentID var id: String?
    var title: String
    var imagePath: String
    var steps: [String]
    var createdAt = Date()
}
