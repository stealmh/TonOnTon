//
//  PhotoColorFeature.swift
//  TonOnTon
//
//  Created by mino on 2024/03/04.
//

import ComposableArchitecture
import SwiftUI

struct PhotoColorFeature: Reducer {
    struct State: Equatable {
        var userselectColors: [UIColor] = []
    }
    enum Action: Equatable {
        case colorTapped(UIColor)
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case nextButtonTapped([UIColor])
        }
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .colorTapped(let color):
            if !state.userselectColors.contains(color) && state.userselectColors.count < 2 {
                state.userselectColors.append(color)
            } else {
                if state.userselectColors.count == 2 && state.userselectColors.contains(color) {
                    state.userselectColors.removeAll { $0 == color }
                }
                
                if state.userselectColors.count == 2 && !state.userselectColors.contains(color) {
                    /// animation: 흔들흔들
                }
                else {
                    state.userselectColors.removeAll { $0 == color }
                }
            }
            return .none
        case .delegate:
            return .none
        }
    }
}
