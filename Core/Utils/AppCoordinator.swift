//
//  AppCoordinator.swift
//  StarNews
//
//  Created by daud daud on 27/04/25.
//

import UIKit

class AppCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        if TokenManager.shared.isLoggedIn() {
            showHome()
        } else {
            showLogin()
        }
    }

    private func showLogin() {
        let loginVC = LoginViewController()
        loginVC.onLoginSuccess = { [weak self] in
            self?.showHome()
        }
        window.rootViewController = UINavigationController(rootViewController: loginVC)
        window.makeKeyAndVisible()
    }
    
    private func showHome() {
//        let homeVC = HomeViewController()
//        homeVC.onLogout = { [weak self] in
//            TokenManager.shared.clear()
//            self?.showLogin()
//        }
//        window.rootViewController = UINavigationController(rootViewController: homeVC)
//        window.makeKeyAndVisible()
    }
}
