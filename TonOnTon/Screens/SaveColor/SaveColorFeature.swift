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
            case selectColor(SelectColorFeature.State = SelectColorFeature.State())
        }
        enum Action: Equatable {
            case addColor(AddColorFeature.Action)
            case selectColor(SelectColorFeature.Action)
        }
        var body: some ReducerOf<Destination> {
            Scope(state: /State.addColor, action: /Action.addColor) {
                AddColorFeature()
            }
            Scope(state: /State.selectColor, action: /Action.selectColor) {
                SelectColorFeature()
            }
        }
    }
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        var viewColorDetect: Bool = false
    }
    
    enum Action: Equatable {
        case addButtonTapped
        case destination(PresentationAction<Destination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
//                state.destination = .addColor()
                state.destination = .selectColor()
                state.viewColorDetect = true
                return .none
            case .destination(.presented(.selectColor(.delegate(let selectColorDelegate)))):
                switch selectColorDelegate {
                case .dismiss:
                    state.destination = nil
                    state.viewColorDetect = false
                    return .none
                case .photoSelectColor:
                    return .none
                case .userSelectColor:
                    state.viewColorDetect = false
                    state.destination = .addColor()
                    return .none
                }
            case .destination(.presented(.addColor(.delegate(let addColorDelegate)))):
                switch addColorDelegate {
                case .saveButtonTapped(let color):
                    state.destination = nil
                    return .none
                case .dismiss:
                    state.destination = nil
                    return .none
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
