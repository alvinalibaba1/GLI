//
//  ProfileViewController.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import UIKit

class ProfileViewController: UIViewController {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "ppadmin")
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "alfagift-admin"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let roleLabel: UILabel = {
        let label = UILabel()
        label.text = "Administrator"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Profile"
        view.backgroundColor = .systemBackground
        
        view.addSubview(containerView)
        containerView.addSubview(profileimageView)
        containerView.addSubview(usernameLabel)
        containerView.addSubview(roleLabel)
        view.addSubview(logoutButton)
        
        
        NSLayoutConstraint.activate([
            
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            profileimageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            profileimageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            profileimageView.widthAnchor.constraint(equalToConstant: 100),
            profileimageView.heightAnchor.constraint(equalToConstant: 100),
            
            usernameLabel.topAnchor.constraint(equalTo: profileimageView.bottomAnchor, constant: 16),
            usernameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            usernameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            logoutButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 40),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc private func logoutTapped() {
        let alert = UIAlertController(
            title: "Logout",
                        message: "Are you sure you want to logout?",
                        preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { [weak self] _ in
            self?.performLogout()
        })
        present(alert, animated: true)
    }
    
    private func performLogout() {
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate {
            sceneDelegate.resetToLogin()
        }
    }
}
