//
//  NewTaskView.swift
//  NTTData-Challenge
//
//  Created by Ana Victoria Frias on 23/10/23.
//

import SwiftUI

struct NewTaskView: View {
    @Binding var isShow: Bool
    @Binding var newTask: NewTask
    var onDismiss: ((_ model: NewTask) -> Void?)
    
    @State private var taskName: String = ""
    @State private var taskPriority: Priority = .normal
    @State private var isEditing: Bool = false
    @State private var selectedDate: Date = Date.now
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading){
                HStack {
                    Text("Add new task")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.isShow = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(self.taskPriority.priorityColor())
                    }
                }
                
                TextField("New Task", text: self.$taskName, onEditingChanged: {
                    self.isEditing = $0
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom)
                
                Text("Priority")
                    .fontWeight(.semibold)
                
                HStack {
                    PriorityView(priorityTitle: "High", selectedPriority: self.$taskPriority)
                        .onTapGesture {
                            self.taskPriority = .high
                        }
                    
                    PriorityView(priorityTitle: "Normal", selectedPriority: self.$taskPriority)
                        .onTapGesture {
                            self.taskPriority = .normal
                        }
                    
                    PriorityView(priorityTitle: "Low", selectedPriority: self.$taskPriority)
                        .onTapGesture {
                            self.taskPriority = .low
                        }
                }.padding(.bottom)
                
                Text("Select a date and time")
                    .fontWeight(.semibold)
                DatePicker("", selection: $selectedDate, in: Date.now...)
                    .labelsHidden()
                    .padding()
                
                Button(action: {
                    guard self.taskName.trimmingCharacters(in: .whitespaces) != "" else {
                        return
                    }
                    
                    self.isShow = false
                    self.newTask = NewTask(name: self.taskName, priority: self.taskPriority, date: self.selectedDate)
                    self.onDismiss(self.newTask)
                }){
                    Text("Add new Task")
                        .font(.system( .title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(self.taskPriority.priorityColor())
                }
                .cornerRadius(10)
                .padding(.vertical)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10, antialiased: true)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct NewTaskView_Previews: PreviewProvider {
    @State private static var defaultTask = NewTask(name: "Default Task", priority: .normal, date: Date.now)
    static var previews: some View {
        NewTaskView(isShow: .constant(true), newTask: $defaultTask, onDismiss: { _ in })
    }
}
