import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var appCoorinator: AppCoordinator?
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let rootNaivgationController = UINavigationController()
        window?.rootViewController = rootNaivgationController
        window?.makeKeyAndVisible()
                        
        appCoorinator = AppCoordinator(navigationController: rootNaivgationController)
        appCoorinator?.start()
    }
}
