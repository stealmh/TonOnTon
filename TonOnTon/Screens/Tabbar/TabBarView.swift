//
//  TabBarView.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture
import SwiftUI

struct TabBarView: View {
    /// - Properties
    private let store: StoreOf<TabBarFeature>
    @ObservedObject var viewStore: ViewStoreOf<TabBarFeature>
    
    init(store: StoreOf<TabBarFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension TabBarView {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        TabView(selection: <#T##Binding<Hashable>?#>, content: <#T##() -> View#>)
    }
}
//MARK: - Preview
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(
            store: Store(
                initialState: .init(),
                reducer: { TabBarFeature() }
                )
        )
    }
}
