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
    @State private var count = 0
    
    var body: some View {
        SectionTabView(tabIndex: $tabIndex) {
            ZStack {
                Text("First View")
            }
            .sectionItem {
                Text("First Tab")
                    .frame(height: 50)
            }
            
            ZStack {
                Text("Second View")
            }
            .sectionItem {
                Text("Second Tap")
            }
            
            ZStack {                
                Text("Third View")
            }
            .sectionItem {
                Text("Third Tap")
            }
        }
        .selectedColor(.blue)
        .lineHeight(2)
        .spacing(20)        
    }
}

#Preview {
    ContentView()
}

struct CountView: View {
    @Binding var count: Int
    
    var body: some View {
        Text("\(count)")
    }
}
