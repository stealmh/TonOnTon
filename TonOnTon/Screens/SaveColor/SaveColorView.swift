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
    @State private var group: [Int] = [1,2,3]
    let columns:[GridItem] = [GridItem(.flexible(), spacing: nil, alignment: .center),
                              GridItem(.flexible(), spacing: nil, alignment: .center)]
    @State private var testColor: [Color] = [.red, .orange, .yellow]
    init(store: StoreOf<SaveColorFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension SaveColorView {
    var body: some View {
        ZStack {
            Color.black.opacity(viewStore.state.viewColorDetect ? 0.7 : 0)
                .zIndex(1)
                .edgesIgnoringSafeArea(.all)
            NavigationStack {
                VStack {
                    if group.isEmpty {
                        Text("저장된 컬러가 없어요🥲")
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(viewStore.state.saveColor, id: \.id) { item in
                                    groupLayout(item)
                                        
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        
                        Text("그룹을 지정해주세요")
                        ScrollView(.horizontal) {
                            LazyVGrid(columns: columns) {
                                ForEach(viewStore.state.nonGroupColor, id: \.id) { item in
                                    nonGroupColorLayout(item)
                                }
                            }
                        }
                    }
                }
                .toolbar {
                    Button(action: { viewStore.send(.addButtonTapped) }) {
                        Image(systemName: "plus")
                    }
                }
                .navigationDestination(
                  store: self.store.scope(state: \.$destination, action: { .destination($0) }),
                  state: /SaveColorFeature.Destination.State.addColor,
                  action: SaveColorFeature.Destination.Action.addColor
                ) { store in
                    AddColorView(store: store)
                }
                .navigationDestination(
                  store: self.store.scope(state: \.$destination, action: { .destination($0) }),
                  state: /SaveColorFeature.Destination.State.photoColor,
                  action: SaveColorFeature.Destination.Action.photoColor
                ) { store in
                    PhotoColorSelectView(store: store)
                }
                .fullScreenCover(
                  store: self.store.scope(state: \.$destination, action: { .destination($0) }),
                  state: /SaveColorFeature.Destination.State.selectColorSheet,
                  action: SaveColorFeature.Destination.Action.selectColor
                ) { store in
                    SelectColorView(store: store)
                        .presentationBackground(.clear)
                }

            }
        }
    }
}
//MARK: - Configure View
extension SaveColorView {
    @ViewBuilder
    func groupLayout(_ item: SaveColor) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.gray)
                .frame(height: 150)
                .overlay {
                    VStack {
                        Spacer()
                        HStack {
                            ForEach(testColor, id: \.self) { data in
                                VStack {
                                    Rectangle()
                                        .foregroundColor(data).opacity(0.3)
                                    Rectangle()
                                        .foregroundColor(data)
                                }
                            }
                        }
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.black).opacity(0.2)
                            .frame(height: 50)
                            .overlay {
                                Text("title")
                            }
                    }
                }
        }
        
    }
    @ViewBuilder
    func nonGroupColorLayout(_ item: CreateColor) -> some View {
        VStack {
            Rectangle()
                .foregroundColor(item.shirtColor)
                .frame(width: 70, height: 70)
            Rectangle()
                .foregroundColor(item.pantsColor)
                .frame(width: 70, height: 70)
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

