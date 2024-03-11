//
//  AddColorFeature.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture
import SwiftUI

struct AddColorFeature: Reducer {
    
    struct State: Equatable {
        var shirtSelectedColor: Color?
        var pantsSelectedColor: Color?
        var saveButtonDetecter: Bool = false
    }
    
    enum Action: Equatable {
        case shirtColorSelected(Color)
        case pantsColorSelected(Color)
        case _saveButtonTapped
        
        case delegate(Delegate)
        enum Delegate: Equatable {
            case saveButtonTapped(CreateColor)
            case dismiss
        }
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .shirtColorSelected(let selectColor):
            state.shirtSelectedColor = selectColor
            return .none
            
        case .pantsColorSelected(let selectColor):
            state.pantsSelectedColor = selectColor
            return .none
            
        case ._saveButtonTapped:
            guard let shirtColor = state.shirtSelectedColor else { return .none }
            guard let pantsColor = state.pantsSelectedColor else { return .none }
            
            let color = CreateColor(id: UUID(), shirtColor: shirtColor,
                                    pantsColor: pantsColor)
            
            return .run { send in await send(.delegate(.saveButtonTapped(color))) }
        case .delegate:
            return .none
        }
    }
}
