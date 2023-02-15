import UIKit

protocol Coordinator: AnyObject {
  var navigationController: UINavigationController? { get set }
  var parentCoordinator: Coordinator? { get set }
  var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
