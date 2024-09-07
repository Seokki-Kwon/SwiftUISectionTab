// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct SectionTabView: View {
    @Binding private var tabIndex: Int
    
    private let views: [AnyView]
    
    public init<V0: View>(tabIndex: Binding<Int>,
                @ViewBuilder content: @escaping () -> TupleView<(V0)>) {
        self._tabIndex = tabIndex
        let cv = content().value
        self.views = [AnyView(cv)]
    }
    
    public init<V0: View, V1: View>(tabIndex: Binding<Int>,
                @ViewBuilder content: @escaping () -> TupleView<(V0, V1)>) {
        self._tabIndex = tabIndex
        let cv = content().value
        self.views = [AnyView(cv.0), AnyView(cv.1)]
    }
    
    public init<V0: View, V1: View, V2: View>(tabIndex: Binding<Int>,
                @ViewBuilder content: @escaping () -> TupleView<(V0, V1, V2)>) {
        self._tabIndex = tabIndex
        let cv = content().value
        self.views = [AnyView(cv.0), AnyView(cv.1), AnyView(cv.2)]
    }
    
    public  var body: some View {
        HStack {
            if views.count > tabIndex {
                views[tabIndex]
            }
        }
    }
}
