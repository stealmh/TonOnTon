//
//  SaveColorFeature.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture

struct SaveColorFeature: Reducer {
    
    struct Destination: Reducer {
        enum State: Equatable {
            case addColor(AddColorFeature.State = AddColorFeature.State())
        }
        enum Action: Equatable {
            case addColor(AddColorFeature.Action)
        }
        var body: some ReducerOf<Destination> {
            Scope(state: /State.addColor, action: /Action.addColor) {
                AddColorFeature()
            }
        }
    }
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
    }
    
    enum Action: Equatable {
        case addButtonTapped
        case destination(PresentationAction<Destination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.destination = .addColor()
                return .none
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
