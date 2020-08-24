import UIKit

final class RecipeDetailsWireframe: RecipeDetailsWireframeProtocol {
    private weak var viewController: UIViewController!
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func popPreviousViewController() {
        self.viewController.navigationController?.popViewController(animated: true)
    }
}
