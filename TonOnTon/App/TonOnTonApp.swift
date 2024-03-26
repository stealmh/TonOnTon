//
//  TonOnTonApp.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import ComposableArchitecture
import SwiftUI

@main
struct TonOnTonApp: App {
    var body: some Scene {
        WindowGroup {
            IntroView(store: Store(initialState: .init(), reducer: { IntroFeature() }))
        }
    }
}
