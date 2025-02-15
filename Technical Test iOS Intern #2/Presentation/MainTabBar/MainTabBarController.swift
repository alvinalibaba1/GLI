//
//  MainTabBarController.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let studentListVC = DIContainer.shared.makeStudentListViewController()
        let profileVC = DIContainer.shared.makeProfileViewController()
        
        let studentListNav = UINavigationController(rootViewController: studentListVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        studentListNav.tabBarItem = UITabBarItem(
            title: "List Students",
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3.fill")
        )
        
        profileNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.circle"),
            selectedImage: UIImage(systemName: "person.circle.fill"))
        
        setViewControllers([studentListNav, profileNav], animated: false)
        
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemBackground
    }
}
