// The Swift Programming Language
// https://docs.swift.org/swift-book
// TODO: .tabBarItem 처럼 클로저로 View를 받는방법

import SwiftUI

public protocol SectionTapComposable {
    func selectedColor(_ color: Color) -> SectionTabView
    func unSelectedColor(_ color: Color) -> SectionTabView
}

public struct SectionTabView: SectionTapComposable, View {
    
    @Binding private var tabIndex: Int
    
    @State private var views: [AnyView]
    @State private var items: [SectionItem] = []
    @State private var offset: CGFloat = .zero
    @State private var width: CGFloat = .zero
    
    private var seletedColor: Color = .black
    private var unSelectedColor: Color = .gray
    
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
                            .overlay(content: {
                                GeometryReader { proxy in
                                    Color.clear.contentShape(Rectangle())
                                        .onAppear {
                                            offset = proxy.frame(in: .named("OuterView")).minX - 10
                                            width = proxy.frame(in: .named("OuterView")).width + 20
                                        }
                                        .onTapGesture {
                                            tabIndex = index
                                            withAnimation {
                                                offset = proxy.frame(in: .named("OuterView")).minX - 10
                                                width = proxy.frame(in: .named("OuterView")).width + 20
                                            }
                                        }
                                }
                            })
                            .foregroundColor(tabIndex == index ? seletedColor : unSelectedColor)
                    }
                    Spacer()
                }
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(.gray)
                    .overlay {
                        Path(CGRect(x: 0, y: 0, width: width, height: 1))
                            .offset(x: offset)
                            .foregroundColor(seletedColor)
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
        .coordinateSpace(name: "OuterView")
        .onPreferenceChange(SectionItemKey.self, perform: { newViwe in
            items.append(contentsOf: newViwe)
        })
    }
    
    public func selectedColor(_ color: Color) -> SectionTabView {
        var instance = self
        instance.seletedColor = color
        return instance
    }
    
    public func unSelectedColor(_ color: Color) -> SectionTabView {
        var instance = self
        instance.unSelectedColor = color
        return instance
    }
}


