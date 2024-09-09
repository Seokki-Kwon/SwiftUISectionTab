// The Swift Programming Language
// https://docs.swift.org/swift-book
// TODO: .tabBarItem 처럼 클로저로 View를 받는방법

import SwiftUI

public struct SectionTabView: View {
    
    @Binding private var tabIndex: Int
    
    @State private var views: [AnyView]
    @State private var items: [SectionItem] = []
    
    public init<V0: View>(tabIndex: Binding<Int>,
                          @ViewBuilder content: () -> TupleView<(V0)>) {
        self._tabIndex = tabIndex
        let cv = content().value
        self.views = [AnyView(cv)]
    }
    
    public init<V0: View, V1: View>(tabIndex: Binding<Int>,
                                    @ViewBuilder content: () -> TupleView<(V0, V1)>) {
        self._tabIndex = tabIndex
        let cv = content().value
        self.views = [AnyView(cv.0), AnyView(cv.1)]
    }
    
    public init<V0: View, V1: View, V2: View>(tabIndex: Binding<Int>,
                                              @ViewBuilder content: () -> TupleView<(V0, V1, V2)>) {
        self._tabIndex = tabIndex
        let cv = content().value
        self.views = [AnyView(cv.0), AnyView(cv.1), AnyView(cv.2)]
    }
    
    public  var body: some View {
        VStack {
            if views.count > tabIndex {
                HStack {
                    // menu
                    ForEach(0..<items.count, id: \.self) { index in
                        items[index].view
                            .onTapGesture {
                                tabIndex = index
                            }
                    }
                }
                
                // content
                Spacer()
                ZStack {
                    ForEach(0..<views.count, id: \.self) { index in
                        views[index]
                            .opacity(index == tabIndex ? 1 : 0)
                    }
                }
                Spacer()
            }
        }
        .onPreferenceChange(SectionItemKey.self, perform: { newViwe in
            items.append(contentsOf: newViwe)
        })
    }
}
