//
//  ContentView.swift
//  ExampleApp
//
//  Created by 권석기 on 9/7/24.
//

import SwiftUI
import SwiftUISectionTab

struct ContentView: View {
    @State private var tabIndex: Int = 0
    
    var body: some View {
        SectionTabView(tabIndex: $tabIndex) {
            ZStack {
                Color.red
                Text("Test View1")
            }
            
            ZStack {
                Color.blue
                Text("Test View2")
            }
            
            ZStack {
                Color.purple
                Text("Test View3")
            }
        }
    }
}

#Preview {
    ContentView()
}
