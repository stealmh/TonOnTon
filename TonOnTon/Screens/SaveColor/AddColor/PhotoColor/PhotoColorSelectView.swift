//
//  PhotoColorSelectView.swift
//  TonOnTon
//
//  Created by mino on 2024/03/04.
//

import ComposableArchitecture
import PhotosUI
import SwiftUI

struct PhotoColorSelectView: View {
    /// - Properties
    private let store: StoreOf<PhotoColorFeature>
    @ObservedObject var viewStore: ViewStoreOf<PhotoColorFeature>
    @State var colorArray:[UIColor] = []
    @State private var selectedItem: PhotosPickerItem?
    @State var selectedImage: Data? = nil
    @State private var myImage: Image?
    @State private var myImage2: UIImage?
    @State private var colorPicker: Color = .white
//    @State private var userselectColors: [UIColor] = []
    
    let columns:[GridItem] = [GridItem(.flexible(), spacing: nil, alignment: .center),
                              GridItem(.flexible(), spacing: nil, alignment: .center),
                              GridItem(.flexible(), spacing: nil, alignment: .center)]
    
    init(store: StoreOf<PhotoColorFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension PhotoColorSelectView {
    var body: some View {
        
        ZStack {
            VStack {
                HStack {

                    PhotosPicker("Select an image", selection: $selectedItem, matching: .images)
                    Spacer()
                    ZStack {
                        CustomColorPicker(color: $colorPicker)
                            .frame(width: 100, height: 50)
                            .clipped()
                            .padding(10)
                            .zIndex(1)
                            .offset(x: -2, y: -3)
                        Text("선택")
                            .offset(x: 3)
                    }
                }
                
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImage = data
                            guard let selectedImage, let uiImage = UIImage(data: selectedImage) else { return }
                            myImage = Image(uiImage: uiImage)
                            myImage2 = uiImage
                        }
                        print("Failed to load the image")
                    }
                }
                
                Image(uiImage: myImage2 ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .frame(maxWidth: .infinity).frame(height: 250).padding(.horizontal,8)
                
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(colorArray,id: \.self) { color in
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(viewStore.userselectColors.contains(color) ? .red : .clear, lineWidth: 2)
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .padding(.horizontal,4)
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(Color(uiColor: color))
                                        .padding(.horizontal,4)
                                }
                                .overlay(alignment: .center) {
                                    HStack {
                                        Text(color.hexString)
                                    }.font(.caption).foregroundColor(.white)
                                }
                                .onTapGesture { viewStore.send(.colorTapped(color)) }
                        }
                    }
                }
                
                Spacer()
                Button(action: { viewStore.send(.delegate(.nextButtonTapped(viewStore.state.userselectColors))) }) {
                    Text("다음")
                }
                .opacity(viewStore.userselectColors.count == 2 ? 1 : 0)
            }
            .onChange(of: myImage2, perform: { uiImage in
                guard let colors = myImage2?.dominantColors() else {return}
                colorArray.removeAll()
                for color in colors {
                    withAnimation {
                        colorArray.append(color)
                    }
                }
                let setColor = Array(Set(colorArray))
                let sortedColors = setColor.sorted { $0.brightness > $1.brightness }
                colorArray = sortedColors
            })
            .onChange(of: colorPicker) { newValue in
                let spoidColor = UIColor(newValue)
                withAnimation {
                    colorArray.append(spoidColor)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}
//MARK: - Preview
struct PhotoColorSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoColorSelectView(
            store: Store(
                initialState: .init(),
                reducer: { PhotoColorFeature() }
            )
        )
    }
}
