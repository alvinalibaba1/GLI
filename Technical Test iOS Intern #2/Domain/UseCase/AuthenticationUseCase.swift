//
//  AuthenticationUseCase.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import Foundation

protocol AuthenticationUseCase {
    func login(username: String, password: String) -> Result<Bool, Error>
}

class DefaultAuthenticationUseCase: AuthenticationUseCase {
    private let repository: AuthenticationRepository
    
    init(repository: AuthenticationRepository) {
        self.repository = repository
    }
    
    func login(username: String, password: String) -> Result<Bool, any Error> {
        return repository.authenticate(username: username, password: password)
    }
}
