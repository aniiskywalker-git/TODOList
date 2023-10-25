//
//  ViewModel.swift
//  NTTData-Challenge
//
//  Created by Ana Victoria Frias on 24/10/23.
//

import SwiftUI
import CoreData

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        /*var context: NSManagedObjectContext
        
        init(context: NSManagedObjectContext) {
            self.context = context
        }
        @FetchRequest(entity: Task.entity(),
                      sortDescriptors: [
                        NSSortDescriptor(keyPath: \Task.complete, ascending: true),
                        NSSortDescriptor(keyPath: \Task.priorityNum, ascending: false)
                      ], animation: .default)
        
        var tasks: FetchedResults<Task>
        
        func deleteTask(index: IndexSet) -> Void {
            withAnimation {
                index.map{tasks[$0]}.forEach(context.delete)
                
                do {
                    try context.save()
                }catch{
                    let nsError = error as NSError
                    fatalError("Unresolved Error \(nsError.localizedDescription), \(nsError.userInfo)")
                }
            }
        }
        
        func addNewTask(name: String, priority: Priority, date: Date?) -> Void {
            let newTask = Task(context: context)
            newTask.id = UUID()
            newTask.name = name
            newTask.priority = priority
            newTask.date = date
            newTask.complete = false
            
            do {
                try context.save()
            }catch {
                print(error.localizedDescription)
            }
            
        }*/
    }
}

