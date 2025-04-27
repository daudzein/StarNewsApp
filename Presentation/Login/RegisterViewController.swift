//
//  RegisterViewController.swift
//  StarNews
//
//  Created by daud daud on 27/04/25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let viewModel = RegisterViewModel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupRegisterButton()
        setupActivityIndicator()
    }

    private func setupRegisterButton() {
        let button = UIButton(type: .system)
        button.setTitle("Register with Auth0", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func registerTapped() {
        activityIndicator.startAnimating()
        viewModel.register { [weak self] success in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                if success {
                    let alert = UIAlertController(title: "Register Success", message: "Welcome!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        let homeVC = HomeViewController()
                        homeVC.modalPresentationStyle = .fullScreen
                        self?.present(homeVC, animated: true)
                    })
                    self?.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Register Failed", message: "Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}
