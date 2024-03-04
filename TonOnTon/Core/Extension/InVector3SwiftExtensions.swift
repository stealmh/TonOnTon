//
//  InVector3SwiftExtensions.swift
//  TonOnTon
//
//  Created by DEV IOS on 2024/03/04.
//

import simd

extension simd_float3 {
    func unpack() -> (Float, Float, Float) {
        return (x, y, z)
    }

    static var identity: simd_float3 {
        return simd_float3(0, 0, 0)
    }

    static func +(lhs: simd_float3, rhs: simd_float3) -> simd_float3 {
        return simd_float3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
    }

    static func /(lhs: simd_float3, rhs: Float) -> simd_float3 {
        return simd_float3(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
    }

    static func /(lhs: simd_float3, rhs: Int) -> simd_float3 {
        return lhs / Float(rhs)
    }
}

