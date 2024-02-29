//
//  IntroFeature.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture

struct IntroFeature: Reducer {
    
    enum State: Equatable {
        case splash(SplashFeature.State = .init())
        
        init() { self = .splash() }
    }
    
    enum Action: Equatable {
        case splash(SplashFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .splash(.delegate(let splashDelegate)):
                switch splashDelegate {
                    case .moveToMain:
                    return .none
                }
            case .splash:
                return .none
            }
        }
    }
}
