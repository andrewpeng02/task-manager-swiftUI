//
//  CheckboxView.swift
//  TasksManager
//
//  Created by 64004080 on 9/30/20.
//  Copyright © 2020 ep. All rights reserved.
//

import SwiftUI

struct CheckboxView: View {
    @Binding var isChecked: Bool
    var animProgress: CGFloat = 1
    var animatableData: CGFloat {
        get { animProgress }
        set { self.animProgress = newValue }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 20, height: 20)
                .foregroundColor(isChecked ? Color.green : Color.gray)
            
            Checkmark()
                .trim(to: isChecked ? 1 : 0)
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 20, height: 20)
        }
    }
}

struct Checkmark: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { p in
            p.move(to: CGPoint(x: 0, y: 5))
            p.addLine(to: CGPoint(x: 10, y: 15))
            p.addLine(to: CGPoint(x: 25, y: -5))
        }
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxView(isChecked: Binding.constant(true), animProgress: 1)
    }
}
