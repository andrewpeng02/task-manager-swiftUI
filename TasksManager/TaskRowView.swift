//
//  TaskRowView.swift
//  TasksManager
//
//  Created by 64004080 on 9/14/20.
//  Copyright © 2020 ep. All rights reserved.
//

import SwiftUI
import CoreData

struct TaskRowView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var task: Task
    @State var animProgress: CGFloat = 1
    
    var body: some View {
        HStack() {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.completeTask()
                }
            }) {
                CheckboxView(isChecked: $task.isComplete, animProgress: animProgress)
            }.offset(y: -7).buttonStyle(BorderlessButtonStyle())
            
            VStack(alignment: .leading) {
                if taskOverdue(date: task.date ?? Date()) {
                    Text(task.desc ?? "")
                    .foregroundColor(.red)
                } else {
                    Text(task.desc ?? "")
                }
                Text(dateToString(date: task.date ?? Date())).font(.caption)
            }
        }
    }
    
    func completeTask() {
        if self.animProgress == 1 {
            self.animProgress = 0
        } else {
            self.animProgress = 1
        }
        task.isComplete.toggle()
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: date)
    }
    
    func taskOverdue(date: Date) -> Bool {
        // Check if current day
        let dateDay = Calendar.current.component(.day, from: date)
        let currentDay = Calendar.current.component(.day, from: Date())
        let dateMonth = Calendar.current.component(.month, from: date)
        let currentMonth = Calendar.current.component(.month, from: Date())
        let dateYear = Calendar.current.component(.year, from: date)
        let currentYear = Calendar.current.component(.year, from: Date())
        if dateDay == currentDay && dateMonth == currentMonth && dateYear == currentYear {
            return false
        }
        
        if date < Date() {
            return true
        } else {
            return false
        }
    }
}


