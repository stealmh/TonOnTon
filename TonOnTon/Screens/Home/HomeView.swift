//
//  HomeView.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    /// - Properties
    private let store: StoreOf<HomeFeature>
    @ObservedObject var viewStore: ViewStoreOf<HomeFeature>
    
    init(store: StoreOf<HomeFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension HomeView {
    var body: some View {
        Text("Hello, this is Home View")
    }
}
//MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            store:
                Store(
                    initialState: .init(),
                    reducer: { HomeFeature() }
                )
        )
    }
}
