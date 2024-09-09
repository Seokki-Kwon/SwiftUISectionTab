// The Swift Programming Language
// https://docs.swift.org/swift-book
// TODO: .tabBarItem 처럼 클로저로 View를 받는방법
// TODO: View가 재렌더링 되지않는현상

import SwiftUI

public protocol SectionTapComposable {
    func selectedColor(_ color: Color) -> SectionTabView
    func unSelectedColor(_ color: Color) -> SectionTabView
    func spacing(_ spacing: CGFloat) -> SectionTabView
    func lineSpacing(_ spacing: CGFloat) -> SectionTabView
    func lineHeight(_ height: CGFloat) -> SectionTabView
    func hideBottomLine(_ isVisible: Bool) -> SectionTabView
}

public struct SectionTabView: SectionTapComposable, View {
    
    @Binding private var tabIndex: Int
    
    @State private var views: [AnyView]
    @State private var items: [SectionItem] = []
    @State private var offset: CGFloat = .zero
    @State private var width: CGFloat = .zero
    
    private var seletedColor: Color = .black
    private var unSelectedColor: Color = .gray
    private var spacing: CGFloat = .zero
    private var lineSpacing: CGFloat = .zero
    private var lineHeight: CGFloat = 1
    private var lineColor: Color = .gray
    private var lineVisible: Bool = false
    
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
    
    public init<V0: View, V1: View, V2: View, V3: View>(tabIndex: Binding<Int>,
                                                        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3)>) {
        self._tabIndex = tabIndex
        let cv = content().value
        self.views = [AnyView(cv.0), AnyView(cv.1), AnyView(cv.2)]
    }
    
    public init<V0: View, V1: View, V2: View, V3: View, V4: View>(tabIndex: Binding<Int>,
                                                                  @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4)>) {
        self._tabIndex = tabIndex
        let cv = content().value
        self.views = [AnyView(cv.0), AnyView(cv.1), AnyView(cv.2)]
    }
    
    public init<V0: View, V1: View, V2: View, V3: View, V4: View, V5: View>(tabIndex: Binding<Int>,
                                                                            @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4, V5)>) {
        self._tabIndex = tabIndex
        let cv = content().value
        self.views = [AnyView(cv.0), AnyView(cv.1), AnyView(cv.2)]
    }
    
    public init<V0: View, V1: View, V2: View, V3: View, V4: View, V5: View, V6: View>(tabIndex: Binding<Int>,
                                                                                      @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4, V5, V6)>) {
        self._tabIndex = tabIndex
        let cv = content().value
        self.views = [AnyView(cv.0), AnyView(cv.1), AnyView(cv.2)]
    }
    
    public  var body: some View {
        VStack(spacing: 0) {
            if views.count > tabIndex {
                VStack(spacing: 0) {
                    HStack(spacing: spacing) {
                        // menu
                        ForEach(0..<items.count, id: \.self) { index in
                            items[index].view
                                .overlay(content: {
                                    GeometryReader { proxy in
                                        Color.clear.contentShape(Rectangle())
                                            .onAppear {
                                                offset = proxy.frame(in: .named("OuterView")).minX - lineSpacing / 2
                                                width = proxy.frame(in: .named("OuterView")).width + lineSpacing
                                            }
                                            .onTapGesture {
                                                tabIndex = index
                                                withAnimation {
                                                    offset = proxy.frame(in: .named("OuterView")).minX - lineSpacing / 2
                                                    width = proxy.frame(in: .named("OuterView")).width + lineSpacing
                                                }
                                            }
                                    }
                                })
                                .foregroundColor(tabIndex == index ? seletedColor : unSelectedColor)
                        }
                    }
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(lineColor)
                        .opacity(lineVisible ? 0 : 1)
                        .overlay {
                            Path(CGRect(x: 0, y: -lineHeight, width: width, height: lineHeight))
                                .foregroundColor(seletedColor)
                                .offset(x: offset)
                            
                        }
                }
                .coordinateSpace(name: "OuterView")
                
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
    
    public func spacing(_ spacing: CGFloat) -> SectionTabView {
        var instance = self
        instance.spacing = spacing
        return instance
    }
    
    public func lineSpacing(_ spacing: CGFloat) -> SectionTabView {
        var instance = self
        instance.lineSpacing = spacing
        return instance
    }
    
    public func lineHeight(_ height: CGFloat) -> SectionTabView {
        var instance = self
        instance.lineHeight = height
        return instance
    }
    
    public func hideBottomLine(_ isVisible: Bool) -> SectionTabView {
        var instance = self
        instance.lineVisible = isVisible
        return instance
    }
}


