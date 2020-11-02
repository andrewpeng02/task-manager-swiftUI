//
//  CatTasksView.swift
//  TasksManager
//
//  Created by 64004080 on 9/14/20.
//  Copyright © 2020 ep. All rights reserved.
//

import SwiftUI

struct CatTasksView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true)],
                  predicate: NSPredicate(format: "isVisible != %@", NSNumber(value: false)))
    var taskList: FetchedResults<Task>
    @State private var taskInput: String = ""
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(taskList) { task in
                        TaskRowView(task: task)
                    }.onDelete(perform: deleteRow)
                }
                .navigationBarTitle("My Tasks")
            }
            Divider()
            HStack {
                TextField("Input task here ([task] [MM/dd])", text: $taskInput)
                    .padding(.horizontal)
                
                Button(action: {
                    self.addTask(taskInput: self.taskInput)
                    self.taskInput = ""
                }) {
                    Image(systemName: "plus.app")
                        .font(.title)
                }
            }
        }
    }
    
    func addTask(taskInput: String) {
        guard taskInput != "" else {return}
        
        let dateInput = String(taskInput.split(separator: " ").suffix(1).joined())
        let date = parseDateInput(dateInput: dateInput)
                
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.isComplete = false
        newTask.isVisible = true
        
        // Check if user inputted a date
        if date == nil {
            let desc = taskInput
            newTask.desc = desc
            newTask.date = Date()
        } else {
            let desc = taskInput.replacingOccurrences(of: " " + dateInput, with: "")
            newTask.desc = desc
            newTask.date = date
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func parseDateInput(dateInput: String) -> Date? {
        let dateInput = dateInput + "/" + String(Calendar.current.component(.year, from: Date()))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: dateInput)
    }
    
    func deleteRow(at offsets: IndexSet) {
        for index in offsets {
            let task = taskList[index]
            context.delete(task)
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}

struct CatTasksView_Previews: PreviewProvider {
    static var previews: some View {
        CatTasksView()
    }
}

