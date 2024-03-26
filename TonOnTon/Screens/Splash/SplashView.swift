//
//  SplashView.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture
import SwiftUI

struct SplashView: View {
    /// - Properties
    private let store: StoreOf<SplashFeature>
    @ObservedObject var viewStore: ViewStoreOf<SplashFeature>
    
    init(store: StoreOf<SplashFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension SplashView {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task { await viewStore.send(._onTask).finish() }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(store: Store(initialState: .init(), reducer: { SplashFeature() }))
    }
}
