//
//  StudentRepository.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import CoreData

protocol StudentRepository {
        func getStudents() -> Result<[Student], Error>
        func deleteStudent(id: String) -> Result<Void, Error>
}
