//
//  RecipeEditorWIreframe.swift
//  MiniCookpad
//
//  Created by Ren Matsushita on 2020/08/25.
//  Copyright © 2020 kensuke-hoshikawa. All rights reserved.
//

import UIKit

final class RecipeEditorWireframe: RecipeEditorWireframeProtocol {
    private weak var viewController: UIViewController!
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func dismiss() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
