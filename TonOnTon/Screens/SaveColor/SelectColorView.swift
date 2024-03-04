//
//  SelectColorView.swift
//  TonOnTon
//
//  Created by mino on 2024/03/04.
//

import ComposableArchitecture
import SwiftUI

struct SelectColorView: View {
    private let store: StoreOf<SelectColorFeature>
    @ObservedObject var viewStore: ViewStoreOf<SelectColorFeature>
    
    init(store: StoreOf<SelectColorFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    var body: some View {
        ZStack {
            Color.white.opacity(0.000001)
                .onTapGesture { viewStore.send(.delegate(.dismiss)) }
            RoundedRectangle(cornerRadius: 30)
                .frame(height: 150)
                .overlay {
                    VStack(spacing: 15) {
                        Button(action: { viewStore.send(.delegate(.userSelectColor)) }) {
                            Capsule()
                                .foregroundColor(.gray)
                                .overlay {
                                    Text("색상 직접 선택하기")
                                }
                        }
                        
                        Button(action: {  }) {
                            Capsule()
                                .foregroundColor(.gray)
                                .overlay {
                                    Text("사진에서 색깔 선택하기")
                                }
                        }
                    }
                    .padding(10)
                }
                .padding(20)
                .onTapGesture {
                    print("tapped")
                }
        }
    }
}

struct SelectColorView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            SelectColorView(store: Store(initialState: .init(), reducer: { SelectColorFeature() }))
        }
    }
}
