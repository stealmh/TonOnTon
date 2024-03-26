//
//  CreateColor.swift
//  TonOnTon
//
//  Created by mino on 2024/02/29.
//

import IdentifiedCollections
import SwiftUI

struct CreateColor: Equatable, Identifiable {
    let id: UUID
    let shirtColor: Color
    let pantsColor: Color
}
