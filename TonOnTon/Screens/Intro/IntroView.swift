//
//  IntroView.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture
import SwiftUI

struct IntroView: View {
    /// - Properties
    private let store: StoreOf<IntroFeature>
    @ObservedObject var viewStore: ViewStoreOf<IntroFeature>
    
    init(store: StoreOf<IntroFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension IntroView {
    var body: some View {
        SwitchStore(self.store) { initialState in
            switch initialState {
            case .splash:
                CaseLet(/IntroFeature.State.splash,
                         action: IntroFeature.Action.splash) { store in
                    SplashView(store: store)
                }
            case .tabBar:
                CaseLet(/IntroFeature.State.tabBar,
                         action: IntroFeature.Action.tabBar) { store in
                    TabBarView(store: store)
                }
            }
        }
    }
}
//MARK: - Preview
struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(
            store:
                Store(
                    initialState: .init(),
                    reducer: { IntroFeature() }
                )
        )
    }
}
