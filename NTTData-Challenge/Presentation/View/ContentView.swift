//
//  ContentView.swift
//  NTTData-Challenge
//
//  Created by Ana Victoria Frias on 23/10/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(),
                  sortDescriptors: [
                    NSSortDescriptor(keyPath: \Task.complete, ascending: true),
                    NSSortDescriptor(keyPath: \Task.priorityNum, ascending: false)
                  ], animation: .default)
    
    var tasks: FetchedResults<Task>
    //to add view model but not updating - TODO: need debugging
    //@StateObject var viewModel: ViewModel
    @State private var showNewTask: Bool = false
    @State private var newTask = NewTask(priority: .normal)
    
    var body: some View {
        //let tasks = viewModel.tasks
        
        NavigationView {
            ZStack {
                List {
                    ForEach(tasks){ task in
                        TaskListRow(task: task)
                    }
                    .onDelete(perform: deleteTask)
                }
                
                if self.showNewTask {
                    BlankView()
                        .onTapGesture {
                            self.showNewTask = false
                        }
                    
                    NewTaskView(isShow: self.$showNewTask, newTask: self.$newTask, onDismiss: { model in
                        addNewTask(name: model.name ?? "", priority: model.priority, date: model.date)
                    })
                        .transition(.move(edge: .bottom))
                        .animation(.bouncy, value: self.showNewTask)
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showNewTask = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.accentColor)
                        }
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .foregroundColor(.blue)
                            .opacity(tasks.count == 0 ? 0.5 : 1)
                            .disabled(tasks.count == 0)
                    }
                
            }
        }.navigationViewStyle(.stack)
    }
    
    func deleteTask(index: IndexSet) -> Void {
        withAnimation {
            index.map{tasks[$0]}.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            }catch{
                let nsError = error as NSError
                fatalError("Unresolved Error \(nsError.localizedDescription), \(nsError.userInfo)")
            }
        }
    }
    
    func addNewTask(name: String, priority: Priority, date: Date?) -> Void {
        let newTask = Task(context: viewContext)
        newTask.id = UUID()
        newTask.name = name
        newTask.priority = priority
        newTask.date = date
        newTask.complete = false
        
        do {
            try viewContext.save()
        }catch {
            print(error.localizedDescription)
        }
        
    }
}
