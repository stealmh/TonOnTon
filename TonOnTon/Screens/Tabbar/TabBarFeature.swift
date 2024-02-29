//
//  TabBarFeature.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture
import Foundation

struct TabBarFeature: Reducer {
    enum Tab { case home, save }
    
    struct State: Equatable {
        var selectedTab: Tab = .home
        
        var home = HomeFeature.State()
        var saveColor = SaveColorFeature.State()
    }
    
    enum Action: Equatable {
        case home(HomeFeature.Action)
        case saveColor(SaveColorFeature.Action)
        case tabSelected(Tab)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .home:
                return .none
            case .saveColor:
                return .none
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            }
        }
        Scope(state: \.home, action: /TabBarFeature.Action.home) {
            HomeFeature()
        }
        Scope(state: \.saveColor, action: /TabBarFeature.Action.saveColor) {
            SaveColorFeature()
        }
    }
}
