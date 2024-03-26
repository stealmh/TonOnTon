//
//  SaveColorFeature.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct SaveColorFeature: Reducer {
    
    struct Destination: Reducer {
        enum State: Equatable {
            case addColor(AddColorFeature.State = AddColorFeature.State())
            case photoColor(PhotoColorFeature.State = PhotoColorFeature.State())
            case selectColorSheet(SelectColorFeature.State = SelectColorFeature.State())
        }
        enum Action: Equatable {
            case addColor(AddColorFeature.Action)
            case photoColor(PhotoColorFeature.Action)
            case selectColor(SelectColorFeature.Action)
        }
        var body: some ReducerOf<Destination> {
            Scope(state: /State.addColor, action: /Action.addColor) {
                AddColorFeature()
            }
            Scope(state: /State.photoColor, action: /Action.photoColor) {
                PhotoColorFeature()
            }
            Scope(state: /State.selectColorSheet, action: /Action.selectColor) {
                SelectColorFeature()
            }
        }
    }
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        var viewColorDetect: Bool = false
        var saveColor: IdentifiedArrayOf<SaveColor> = []
        var nonGroupColor: IdentifiedArrayOf<CreateColor> = []
    }
    
    enum Action: Equatable {
        case addButtonTapped
        case colorAddGroup(id: UUID, dragColor: CreateColor)
        case modalDismiss
        case itemWillAdd
        case destination(PresentationAction<Destination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
//                state.destination = .addColor()
                state.destination = .selectColorSheet()
                state.viewColorDetect = true
                return .none
                
            case .colorAddGroup(let id, let dragColor):
                state.saveColor[id: id]?.color.append(dragColor)
                return .none
                
                
            case .modalDismiss:
                state.destination = nil
                state.viewColorDetect = false
                return .none
                
            case .itemWillAdd:
                let item = SaveColor(id: UUID(), title: "그룹 \(state.saveColor.count + 1)", color: [])
                state.saveColor.append(item)
                return .none
                
            /// Delegate: 색깔 선택 창
            case .destination(.presented(.selectColor(.delegate(let selectColorDelegate)))):
                switch selectColorDelegate {
                case .dismiss:
                    state.destination = nil
                    state.viewColorDetect = false
                    return .none
                case .photoSelectColor:
                    state.viewColorDetect = false
                    state.destination = .photoColor()
                    return .none
                case .userSelectColor:
                    state.viewColorDetect = false
                    state.destination = .addColor()
                    return .none
                case .addGroup:
                    return .run { send in
                        await send(.modalDismiss)
                        await send(.itemWillAdd, animation: .spring())
                    }
                }
                
            /// Delegate: 색깔 직접 입력 창
            case .destination(.presented(.addColor(.delegate(let addColorDelegate)))):
                switch addColorDelegate {
                case .saveButtonTapped(let color):
                    state.nonGroupColor.append(color)
                    return .run { send in await send(.modalDismiss) }
//                    state.destination = nil
                    return .none
                case .dismiss:
                    state.destination = nil
                    return .none
                }
                
            case .destination(.presented(.photoColor(.delegate(let photoColorDelegate)))):
                switch photoColorDelegate {
                case .nextButtonTapped(let colors):
                    guard let uiColorFirst = colors.first,
                          let uiColorSecond = colors.last else {
                        print("return")
                        return .none }
                    let firstColor = Color(uiColor: uiColorFirst)
                    let secondColor = Color(uiColor: uiColorSecond)
                    let color = CreateColor(id: UUID(), shirtColor: firstColor, pantsColor: secondColor)
                    state.nonGroupColor.append(color)
                    
                    return .run { send in await send(.modalDismiss) }
                }
                
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
        ._printChanges()
    }
}
