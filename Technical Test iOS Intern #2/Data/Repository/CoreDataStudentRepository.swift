//
//  CoreDataStudentRepository.swift
//  Technical Test iOS Intern #2
//
//  Created by Alvin Reyvaldo on 15/02/25.
//

import CoreData

import CoreData
import Foundation

class CoreDataStudentRepository: StudentRepository {
    
    
    private var context: NSManagedObjectContext
    
    
    private let localStudents = [
            Student(
                id: "1",
                name: "John Anderson",
                address: "123 Maple Street, Apt 4B, New York, NY 10001",
                profileImage: "pp1"
            ),
            Student(
                id: "2",
                name: "Sarah Martinez",
                address: "456 Oak Avenue, Suite 201, Los Angeles, CA 90012",
                profileImage: "pp2"
            ),
            Student(
                id: "3",
                name: "Michael Chen",
                address: "789 Pine Road, Chicago, IL 60601",
                profileImage: "pp3"
            ),
            Student(
                id: "4",
                name: "Emily Thompson",
                address: "321 Cedar Lane, Boston, MA 02108",
                profileImage: "pp4"
            ),
            Student(
                id: "5",
                name: "David Wilson",
                address: "567 Birch Street, Seattle, WA 98101",
                profileImage: "pp5"
            ),
            Student(
                id: "6",
                name: "Maria Rodriguez",
                address: "890 Palm Drive, Miami, FL 33101",
                profileImage: "pp6"
            ),
            Student(
                id: "7",
                name: "James Lee",
                address: "234 Sunset Blvd, San Francisco, CA 94110",
                profileImage: "pp7"
            ),
            Student(
                id: "8",
                name: "Sophie Brown",
                address: "432 River Road, Austin, TX 78701",
                profileImage: "pp8"
            ),
            Student(
                id: "9",
                name: "Alex Kim",
                address: "678 Mountain View, Denver, CO 80202",
                profileImage: "pp9"
            ),
            Student(
                id: "10",
                name: "Isabella Patel",
                address: "901 Lake Avenue, Portland, OR 97201",
                profileImage: "pp10"
            )
        ]
    
    init(context: NSManagedObjectContext) {
        self.context = context
        syncWithLocalData()
    }
    
    
    func getStudents() -> Result<[Student], Error> {
        let fetchRequest: NSFetchRequest<StudentEntity> = StudentEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            let entities = try context.fetch(fetchRequest)
            let students = entities.map { entity in
                Student(
                    id: entity.id ?? "",
                    name: entity.name ?? "",
                    address: entity.address ?? "",
                    profileImage: entity.profileImage ?? ""
                )
            }
            return .success(students)
        } catch {
            return .failure(StudentError.fetchFailed)
        }
    }
    
    
    func deleteStudent(id: String) -> Result<Void, Error> {
        let fetchRequest: NSFetchRequest<StudentEntity> = StudentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let entities = try context.fetch(fetchRequest)
            if let entity = entities.first {
                context.delete(entity)
                try context.save()
            }
            return .success(())
        } catch {
            return .failure(StudentError.deleteFailed)
        }
    }
    
    private func syncWithLocalData() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "StudentEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            
            try context.execute(deleteRequest)
            try context.save()
            
            
            for student in localStudents {
                let entity = StudentEntity(context: context)
                updateEntity(entity, with: student)
            }
            
            
            try context.save()
        } catch {
            print("Failed to sync data: \(error)")
        }
    }
    
    
    private func updateEntity(_ entity: StudentEntity, with student: Student) {
        entity.id = student.id
        entity.name = student.name
        entity.address = student.address
        entity.profileImage = student.profileImage
    }
}

