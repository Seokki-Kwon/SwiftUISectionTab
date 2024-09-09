//
//  File.swift
//
//
//  Created by 권석기 on 9/7/24.
//

import SwiftUI

struct SectionItemKey: PreferenceKey {
    static var defaultValue: [SectionItem] = []
    
    static func reduce(value: inout [SectionItem], nextValue: () -> [SectionItem]) {
        value.append(contentsOf: nextValue())
    }
}


struct SectionItem: Identifiable, Equatable {
    let id: UUID
    let view: AnyView
    
    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        lhs.id == rhs.id
    }
}

public extension View {
    func sectionItem<V: View>(@ViewBuilder _ label: () -> V) -> some View {
        self
            .preference(key: SectionItemKey.self, value: [SectionItem(id: UUID(), view: AnyView(label()))])
    }
}






