//
//  Persistence.swift
//  NTTData-Challenge
//
//  Created by Ana Victoria Frias on 23/10/23.
//

import SwiftUI
import CoreData

class PersistenceController: ObservableObject {


    let container = NSPersistentContainer(name: "TaskToDo")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed \(error.localizedDescription)")
            }
        }
    }
}

struct PersistenceControllerPreview {
    static let shared = PersistenceController()
    

    static var preview: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
