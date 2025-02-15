//
//  AuthenticationError.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import Foundation
enum AuthenticationError: LocalizedError {
    case emptyUsername
    case emptyPassword
    case invalidUsername
    case invalidPassword
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .emptyUsername:
            return "Please enter your username"
        case .emptyPassword:
            return "Please enter your password"
        case .invalidUsername:
            return "Invalid Username"
        case .invalidPassword:
            return "Incorrect password"
        case .invalidCredentials:
            return "Invalid username or password"
        }
    }
}
