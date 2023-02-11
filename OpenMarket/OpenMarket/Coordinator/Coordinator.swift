import UIKit

protocol Coordinator: AnyObject {
  var navigationController: UINavigationController? { get set }
  var parentCoordinator: Coordinator? { get set }
  var childCoordinators: [Coordinator] { get set }
}
