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
//    @State private var testColor: [Color] = [.red, .orange, .yellow]
    @State private var testColor: [Color] = []
    @State private var draggedColor: CreateColor?
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
                                    groupLayout(item.color)
                                        .onDrop(of: [.text],
                                                delegate: MyDropDelegate(draggedItem: $draggedColor,
                                                                         action: { dragColor in
                                            viewStore.send(.colorAddGroup(id: item.id, dragColor: dragColor), animation: .spring())
                                        }))
                                        
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        
                        Text("그룹을 지정해주세요")
                        ScrollView(.horizontal) {
                            VStack {
                                ForEach(viewStore.state.nonGroupColor, id: \.id) { item in
                                    nonGroupColorLayout(item)
                                    /// 끌어오는 곳
                                        .onDrag {
                                            self.draggedColor = item
                                            return NSItemProvider()
                                        }
                                }
                            }
                            .padding(.leading, 20)
                        }
                    }
                }
                .chainningToolBar(viewStore: viewStore)
                .chainningNavigation(store: store)
                .chainningFullScreenCover(store: store)

            }
        }
    }
}
extension SaveColorView {
    struct MyDropDelegate: DropDelegate {
        @Binding var draggedItem: CreateColor?
        var action: (CreateColor) -> ()?
        
        func performDrop(info: DropInfo) -> Bool {
            guard let draggedItem else { return false }
            action(draggedItem)
            return true
        }

        func dropEntered(info: DropInfo) {
            print(#function)
        }
        
        func dropExited(info: DropInfo) {
            print(#function)
        }
    }
}
//MARK: - Configure View
extension SaveColorView {
    @ViewBuilder
    func groupLayout(_ item: [CreateColor]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.gray)
                .frame(height: 150)
                .overlay {
                    VStack {
                        Spacer()
                        HStack {
                            ForEach(item, id: \.id) { closeColor in
                                VStack {
                                    Rectangle()
                                        .foregroundColor(closeColor.shirtColor)
                                    Rectangle()
                                        .foregroundColor(closeColor.pantsColor)
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
//MARK: - Helper Method
extension View {
    func chainningToolBar(viewStore: ViewStoreOf<SaveColorFeature>) -> some View {
        self
            .toolbar {
                Button(action: { viewStore.send(.addButtonTapped) }) {
                    Image(systemName: "plus")
                }
            }
    }
    @ViewBuilder
    func chainningNavigation(store: StoreOf<SaveColorFeature>) -> some View {
        self
            .navigationDestination(
              store: store.scope(state: \.$destination, action: { .destination($0) }),
              state: /SaveColorFeature.Destination.State.addColor,
              action: SaveColorFeature.Destination.Action.addColor
            ) { store in
                AddColorView(store: store)
            }
            .navigationDestination(
              store: store.scope(state: \.$destination, action: { .destination($0) }),
              state: /SaveColorFeature.Destination.State.photoColor,
              action: SaveColorFeature.Destination.Action.photoColor
            ) { store in
                PhotoColorSelectView(store: store)
            }
    }
    
    @ViewBuilder
    func chainningFullScreenCover(store: StoreOf<SaveColorFeature>) -> some View {
        self
            .fullScreenCover(
              store: store.scope(state: \.$destination, action: { .destination($0) }),
              state: /SaveColorFeature.Destination.State.selectColorSheet,
              action: SaveColorFeature.Destination.Action.selectColor
            ) { store in
                SelectColorView(store: store)
                    .presentationBackground(.clear)
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

