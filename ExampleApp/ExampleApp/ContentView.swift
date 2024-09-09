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
            .sectionItem {
                Text("Tab1")
                    .font(.title)
            }
            
            ZStack {
                Color.blue
                Text("Test View2")
            }            
            .sectionItem {
                Text("Tab2")
                    .font(.title)
            }
            
            ZStack {
                Color.purple
                Text("Test View3")
            }
            .sectionItem {
                Text("Tab3")
                    .font(.title)
            }
        }
        .selectedColor(.purple)
        .spacing(40)
        .lineSpacing(20)
    }
}

#Preview {
    ContentView()
}
