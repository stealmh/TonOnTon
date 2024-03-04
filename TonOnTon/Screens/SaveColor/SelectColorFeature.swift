//
//  SelectColorFeature.swift
//  TonOnTon
//
//  Created by mino on 2024/03/04.
//

import ComposableArchitecture

struct SelectColorFeature: Reducer {
    struct State: Equatable {}
    enum Action: Equatable {
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case userSelectColor
            case photoSelectColor
            case dismiss
        }
    }
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .delegate:
            return .none
        }
    }
}
