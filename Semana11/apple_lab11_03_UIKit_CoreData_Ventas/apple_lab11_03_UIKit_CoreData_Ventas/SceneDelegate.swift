//
//  SceneDelegate.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Created by Sarai Sthefanie Soto on 12/11/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Obtenemos la escena de ventana que nos entrega el sistema
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Creamos la ventana POR CÓDIGO (sin storyboard):
        // 1. La ventana se asocia a la escena
        // 2. El controlador raíz es un UINavigationController que envuelve al Login,
        //    así podemos navegar entre pantallas con push/pop
        let window = UIWindow(windowScene: windowScene)
        // Tint global: todos los botones, tabs e íconos heredan el color de marca
        window.tintColor = Estilos.colorPrimario
        window.rootViewController = UINavigationController(rootViewController: LoginViewController())
        self.window = window
        window.makeKeyAndVisible() // mostramos la ventana en pantalla
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

