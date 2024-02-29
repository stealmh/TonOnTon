//
//  SplashFeature.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture

struct SplashFeature: Reducer {
    struct State: Equatable {}
    
    enum Action: Equatable {
        case _onTask
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case moveToMain
        }
    }
    
    @Dependency(\.continuousClock) var clock
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case ._onTask:
            return .run { send in
                try await self.clock.sleep(for: .milliseconds(1500))
                await send(.delegate(.moveToMain))
            }
        case .delegate:
            return .none
        }
    }
}
