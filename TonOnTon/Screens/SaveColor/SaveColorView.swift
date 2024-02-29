//
//  SaveColorView.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture
import SwiftUI

struct SaveColorView: View {
    /// - Properties
    private let store: StoreOf<SaveColorFeature>
    @ObservedObject var viewStore: ViewStoreOf<SaveColorFeature>
    
    init(store: StoreOf<SaveColorFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension SaveColorView {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello, this is Save Color View!")
            }
            .toolbar {
                Button(action: { viewStore.send(.addButtonTapped) }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(
              store: self.store.scope(state: \.$destination, action: { .destination($0) }),
              state: /SaveColorFeature.Destination.State.addColor,
              action: SaveColorFeature.Destination.Action.addColor
            ) { store in
                AddColorView(store: store)
                    .presentationDetents([.fraction(0.9)])
//                    .interactiveDismissDisabled()
    //                .presentationBackground(.gray.opacity(0.6))
            }

        }
    }
}
//MARK: - Preview
struct SaveColorView_Previews: PreviewProvider {
    static var previews: some View {
        SaveColorView(
            store: Store(
                initialState: .init(),
                reducer: { SaveColorFeature() }
            )
        )
    }
}
