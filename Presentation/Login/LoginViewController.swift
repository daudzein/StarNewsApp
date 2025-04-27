//
//  LoginViewController.swift
//  StarNews
//
//  Created by daud daud on 27/04/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    var onLoginSuccess: (() -> Void)?
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login with Auth0", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupButtons()
    }

    private func setupButtons() {
        view.addSubview(loginButton)
        view.addSubview(registerButton)

        // Add constraints for login button
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // Add constraints for register button
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16)
        ])
    }

    @objc private func loginTapped() {
        viewModel.login { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.onLoginSuccess?()
                } else {
                    let alert = UIAlertController(title: "Login Failed", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }

    @objc private func registerTapped() {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
