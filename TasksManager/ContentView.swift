//
//  ContentView.swift
//  TasksManager
//
//  Created by 64004080 on 9/14/20.
//  Copyright © 2020 ep. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        CatTasksView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

