//
//  LoginViewController.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import UIKit

class LoginViewController: UIViewController {
    private let authenticationUseCase: AuthenticationUseCase
    
    private var isLoading: Bool = false {
        didSet {
            updateLoadingState()
        }
    }
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    init(authenticationUseCase: AuthenticationUseCase) {
        self.authenticationUseCase = authenticationUseCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        loginButton.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor)
        ])
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func updateLoadingState() {
        loginButton.isEnabled = !isLoading
        
        if isLoading {
            loginButton.tag = 1
            loginButton.setTitle("", for: .disabled)
            activityIndicator.startAnimating()
        } else {
            loginButton.tag = 0
            loginButton.setTitle("Login", for: .normal)
            activityIndicator.stopAnimating()
        }
    }
    
    @objc private func loginButtonTapped() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            let username = (usernameTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            let password = (passwordTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            
            let result = authenticationUseCase.login(username: username, password: password)
            
            self.isLoading = false
            
            switch result {
            case .success:
                if let sceneDelegate = UIApplication.shared.connectedScenes
                    .first?.delegate as? SceneDelegate {
                    sceneDelegate.navigateToMainInterface()
                }
            case .failure(let error):
                handleAuthenticationError(error)
            }
        }
    }
    
    private func handleAuthenticationError(_ error: Error) {
            
            resetErrorStyling()
            
            if let authError = error as? AuthenticationError {
                switch authError {
                case .emptyUsername, .invalidUsername:
                    applyErrorStyling(to: usernameTextField)
                case .emptyPassword, .invalidPassword:
                    applyErrorStyling(to: passwordTextField)
                case .invalidCredentials:
                    applyErrorStyling(to: usernameTextField)
                    applyErrorStyling(to: passwordTextField)
                }
            }
            
        
            showAlert(message: error.localizedDescription)
        }
        
        private func applyErrorStyling(to textField: UITextField) {
            textField.layer.borderColor = UIColor.systemRed.cgColor
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5
            
            
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            animation.duration = 0.6
            animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.5, 2.5, 0.0]
            textField.layer.add(animation, forKey: "shake")
        }
        
        private func resetErrorStyling() {
            [usernameTextField, passwordTextField].forEach { textField in
                textField.layer.borderWidth = 0
                textField.layer.borderColor = nil
            }
        }
        
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            
            textField.layer.borderWidth = 0
            textField.layer.borderColor = nil
        }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
