//
//  TaskListRow.swift
//  NTTData-Challenge
//
//  Created by Ana Victoria Frias on 23/10/23.
//

import Foundation
import SwiftUI

struct TaskListRow: View {
    @ObservedObject var task: Task
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Toggle(isOn: self.$task.complete){
            VStack {
                HStack {
                    Text(self.task.name ?? "")
                        .fontWeight(.bold)
                        .strikethrough(self.task.complete, color: self.task.priority.priorityColor())
                        .opacity(self.task.complete ? 0.5 : 1)
                    
                    Spacer()
                    
                    Circle()
                        .frame(width: 10)
                        .foregroundColor(self.task.priority.priorityColor())
                }
                Text(self.task.date?.formatted(date: .abbreviated, time: .shortened) ?? "")
                    .font(.callout)
                    .strikethrough(self.task.complete, color: self.task.priority.priorityColor())
                    .opacity(self.task.complete ? 0.5 : 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .toggleStyle(CheckBoxStyle(taskColor: self.task.priority.priorityColor()))
        .onReceive(self.task.objectWillChange){_ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}


// you may remove this preview or update
struct TaskListRow_Previews: PreviewProvider {
    static var previews: some View {
        let testTask = Task(context: PersistenceControllerPreview.preview.container.viewContext)
        testTask.id = UUID()
        testTask.name = "Test Task"
        testTask.complete = true
        testTask.priority = .low
        testTask.date = Date.now
        
        
        return TaskListRow(task: testTask)
    }
}
