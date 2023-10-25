//
//  TaskCoreData.swift
//  NTTData-Challenge
//
//  Created by Ana Victoria Frias on 23/10/23.
//

import SwiftUI
import CoreData

extension Task {
    var priority: Priority {
        get {
            Priority(rawValue: Int(self.priorityNum)) ?? .normal
        }
         
        set {
            self.priorityNum = Int32(newValue.rawValue)
        }
    }
}

enum Priority: Int {
    case low = 0
    case normal = 1
    case high = 2
    
    var priorityType: String {
        switch rawValue {
            case Priority.low.rawValue: return "low"
            case Priority.normal.rawValue: return "normal"
            case Priority.high.rawValue: return "high"
            default: return ""
        }
    }
    
    func priorityColor() -> Color {
        switch rawValue {
            case Priority.low.rawValue: return .green
            case Priority.normal.rawValue: return .orange
            case Priority.high.rawValue: return .red
            default: return .orange
        }
    }
}
