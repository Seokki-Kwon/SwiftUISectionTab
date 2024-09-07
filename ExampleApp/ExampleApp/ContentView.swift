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
        VStack {
            SectionTabView(tabIndex: $tabIndex) {
                Text("Test View1")
                Text("Test View2")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
