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
        TabView(selection: viewStore.binding(
            get: \.selectedTab,
            send: TabBarFeature.Action.tabSelected)) {
                HomeView(store: self.store.scope(state: \.home, action: TabBarFeature.Action.home))
                    .tag(TabBarFeature.Tab.home)
                    .tabItem {
                        Text("hello!")
                    }
                
                SaveColorView(store: self.store.scope(state: \.saveColor, action: TabBarFeature.Action.saveColor))
                    .tag(TabBarFeature.Tab.save)
                    .tabItem {
                        Text("save!")
                    }
            }
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
