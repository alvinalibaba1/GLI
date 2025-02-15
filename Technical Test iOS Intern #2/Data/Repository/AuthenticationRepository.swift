//
//  AuthenticationErorr.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import Foundation


protocol AuthenticationRepository {
    func authenticate(username: String, password: String) -> Result<Bool, Error>
}

class DefaultAuthenticationRepository: AuthenticationRepository {
    func authenticate(username: String, password: String) -> Result<Bool, any Error> {
        
        if username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return .failure(AuthenticationError.emptyUsername)
        }
        
        if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return .failure(AuthenticationError.emptyPassword)
        }
        
        let expectedUsername = "alfagift-admin"
        if username != expectedUsername {
            return .failure(AuthenticationError.invalidUsername)
        }
        
        let expectedPassword = "asdf"
        if password != expectedPassword {
            return .failure(AuthenticationError.invalidPassword)
        }
        
        return .success(true)
    }
}


