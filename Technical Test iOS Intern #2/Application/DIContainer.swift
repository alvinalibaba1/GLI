//
//  DIContainer.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import Foundation
import UIKit

class DIContainer {
    static let shared = DIContainer()
    private init() {}
    
    private lazy var authenticationRepository: AuthenticationRepository = {
        return DefaultAuthenticationRepository()
    }()
    
    private lazy var studentRepository: StudentRepository = {
           let repository = CoreDataStudentRepository(context: CoreDataManager.shared.context)
           return repository
       }()
    
    private lazy var authenticationUseCase: AuthenticationUseCase = {
        return DefaultAuthenticationUseCase(repository: authenticationRepository)
    }()
    
    private lazy var studentUseCase: StudentUseCase = {
        return DefaultStudentUseCase(repository: studentRepository)
    }()
    
    func makeLoginViewController() -> UIViewController {
        return LoginViewController(authenticationUseCase: authenticationUseCase)
    }
    
    func makeStudentListViewController() -> UIViewController {
        return StudentListViewController(studentUseCase: studentUseCase)
    }
    
    func makeMainTabBarControler() -> UIViewController {
        return MainTabBarController()
    }
    
    func makeProfileViewController() -> UIViewController {
        return ProfileViewController()
    }
}
