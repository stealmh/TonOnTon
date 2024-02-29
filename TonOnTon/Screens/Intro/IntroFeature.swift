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
        case tabBar(TabBarFeature.State = TabBarFeature.State())
        
        init() { self = .splash() }
    }
    
    enum Action: Equatable {
        case splash(SplashFeature.Action)
        case tabBar(TabBarFeature.Action)
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .splash(.delegate(let splashDelegate)):
                switch splashDelegate {
                    case .moveToMain:
                    return .run { send in await send(._changeScreen(.tabBar(.init())), animation: .spring()) }
                }
            case .splash:
                return .none
            case .tabBar:
                return .none
            }
        }
        .ifCaseLet(/State.splash, action: /Action.splash) {
            SplashFeature()
        }
        .ifCaseLet(/State.tabBar, action: /Action.tabBar) {
            TabBarFeature()
        }
    }
}
