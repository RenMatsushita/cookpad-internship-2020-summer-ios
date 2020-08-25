import UIKit

final class RecipeListWireframe: RecipeListWireframeProtocol {
    private weak var viewController: UIViewController!
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func openRecipeDetails(recipeID: String) {
        let vc = RecipeDetailsViewBuilder.build(withRecipeId: recipeID)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openRecipeEditor() {
        let vc = RecipeEditorViewBuilder.build()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        viewController.present(nav, animated: true, completion: nil)
    }
}
