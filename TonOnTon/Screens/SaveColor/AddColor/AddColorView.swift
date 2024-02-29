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
    private let color: [Color] = [.red, .pink, .orange, .yellow, .green, .blue, .indigo, .brown, .purple, .white, .gray, .black]
    @State private var pointColorActive: Bool = false
    
    init(store: StoreOf<AddColorFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension AddColorView {
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.1)
            VStack {
                Text("색상 선택")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                VStack(alignment: .leading, spacing: 5) {
                    Section {
                        HStack(spacing: 10) {
                            Image("shirt")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("상의")
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(color, id: \.self) { color in
                                    ZStack(alignment: .topTrailing) {
                                        RoundedRectangle(cornerRadius: 30)
                                            .frame(width: 90, height: 90)
                                            .foregroundColor(color)
                                            .onTapGesture {
                                                viewStore.send(.shirtColorSelected(color))
                                            }
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .opacity(viewStore.state.shirtSelectedColor == color ? 1 : 0)
                                            .animation(.spring(), value: viewStore.state.shirtSelectedColor)
                                            .foregroundColor(viewStore.state.shirtSelectedColor == .white ? .black : .white)
                                            .padding([.top, .trailing], 15)
                                    }
                                }
                            }
                        }
                    }
                        HStack(spacing: 10) {
                            Text("포인트 컬러가 있나요?")
                            Spacer()
                            Button {
                                pointColorActive = true
                            } label: {
                                Text("네!")
                            }
                            
                            Button {
                                pointColorActive = false
                            } label: {
                                Text("없어요!")
                            }

                        }
                        .frame(height: viewStore.state.shirtSelectedColor != nil ? 50 : 0)
                        .opacity(viewStore.state.shirtSelectedColor != nil ? 1 : 0)
                        .transition(.opacity)
                        .animation(.spring(), value: viewStore.state.shirtSelectedColor)
                    
                    /// IfLetStore로 교체
                    if pointColorActive {
                        VStack {
                            HStack(spacing: 10) {
                                Image("shirt")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("상의 (포인트 컬러)")
                                Spacer()
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(color, id: \.self) { color in
                                        ZStack(alignment: .topTrailing) {
                                            RoundedRectangle(cornerRadius: 30)
                                                .frame(width: 100, height: 100)
                                                .foregroundColor(color)
                                                .onTapGesture {
                                                    viewStore.send(.shirtPointColorSelected(color))
                                                }
                                            Image(systemName: "checkmark")
                                                .resizable()
                                                .frame(width: 15, height: 15)
                                                .opacity(viewStore.state.shirtPointColor == color ? 1 : 0)
                                                .animation(.spring(), value: viewStore.state.shirtPointColor)
                                                .foregroundColor(viewStore.state.shirtPointColor == .white ? .black : .white)
                                                .padding([.top, .trailing], 15)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                Section {
                    HStack(spacing: 10) {
                        Image("pants")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("하의")
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(color, id: \.self) { color in
                                ZStack(alignment: .topTrailing) {
                                    RoundedRectangle(cornerRadius: 30)
                                        .frame(width: 90, height: 90)
                                        .foregroundColor(color)
                                        .onTapGesture {
                                            viewStore.send(.pantsColorSelected(color))
                                        }
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                        .opacity(viewStore.state.pantsSelectedColor == color ? 1 : 0)
                                        .animation(.spring(), value: viewStore.state.pantsSelectedColor)
                                        .foregroundColor(viewStore.state.pantsSelectedColor == .white ? .black : .white)
                                        .padding([.top, .trailing], 15)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                Button(action: { viewStore.send(._saveButtonTapped) }) {
                    Capsule()
                        .frame(height: 50)
                        .foregroundColor(.yellow).opacity(0.7)
                        .overlay {
                            Text("이거로 결정")
                                .bold()
                                .foregroundColor(.brown)
                        }
                }
            }
            .padding(20)
        }
        .ignoresSafeArea()
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
