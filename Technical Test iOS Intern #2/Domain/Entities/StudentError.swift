//
//  StudenteError.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import Foundation
enum StudentError: LocalizedError {
    case saveFailed
    case deleteFailed
    case fetchFailed
    
    var errorDescription: String? {
        switch self {
        case .saveFailed:
            return "Failed to save student"
        case .deleteFailed:
            return "Failed to delete student"
        case .fetchFailed:
            return "Failed to fetch students"
        }
    }
}
