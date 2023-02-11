import UIKit

protocol Coordinator: AnyObject {
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
  
  func start()
}

class MainCoordinator: NSObject, Coordinator {
  
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = MainViewController()
    vc.coordinator = self
    navigationController.delegate = self
    navigationController.pushViewController(vc, animated: false)
  }
  
  func childDidFinish(_ child: Coordinator?) {
    for (index, coordinator) in childCoordinators.enumerated() {
      if coordinator === child {
        childCoordinators.remove(at: index)
        break
      }
    }
  }
}

extension MainCoordinator: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    
    guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
      return
    }
    
    if navigationController.viewControllers.contains(fromViewController) {
      return
    }
  }
}
