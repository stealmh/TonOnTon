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
    }
    
    enum Action: Equatable {}
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
}
