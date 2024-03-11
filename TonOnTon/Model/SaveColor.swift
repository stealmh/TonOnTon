//
//  SaveColor.swift
//  TonOnTon
//
//  Created by DEV IOS on 2024/03/11.
//

import IdentifiedCollections
import Foundation
import SwiftUI

struct SaveColor: Equatable, Identifiable {
    var id: UUID
    let title: String
    let Color: [Color]
}
