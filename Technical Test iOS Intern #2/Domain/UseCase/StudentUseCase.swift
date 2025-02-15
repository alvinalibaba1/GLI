//
//  StudentUseCase.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import Foundation

protocol StudentUseCase {
    func getStudents() -> Result<[Student], Error>
}

class DefaultStudentUseCase: StudentUseCase {
    private let repository: StudentRepository
    
    init(repository: StudentRepository) {
        self.repository = repository
    }
    
    func getStudents() -> Result<[Student], any Error> {
        return repository.getStudents()
    }
}
