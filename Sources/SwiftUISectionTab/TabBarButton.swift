//
//  SwiftUIView.swift
//  
//
//  Created by 권석기 on 9/7/24.
//

import SwiftUI

struct TabBarButton: View {
    
    private let text: String
    
    @Binding private var isSelected: Bool
    
    init(text: String, isSelected: Binding<Bool>) {
        self.text = text
        self._isSelected = isSelected
    }
    var body: some View {
        Text("\(text) Tap!")
    }
}


