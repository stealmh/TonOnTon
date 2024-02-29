//
//  AddColorView.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture
import SwiftUI

struct AddColorView: View {
    /// - Properties
    private let store: StoreOf<AddColorFeature>
    @ObservedObject var viewStore: ViewStoreOf<AddColorFeature>
    
    init(store: StoreOf<AddColorFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension AddColorView {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .onDisappear { viewStore.send(.delegate(.disappear)) }
    }
}
//MARK: - Preview
struct AddColorView_Previews: PreviewProvider {
    static var previews: some View {
        AddColorView(
            store:
                Store(
                    initialState: .init(),
                    reducer: { AddColorFeature() }
                )
        )
    }
}
