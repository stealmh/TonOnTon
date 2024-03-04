//
//  Memoization.swift
//  TonOnTon
//
//  Created by DEV IOS on 2024/03/04.
//

func memoize<T: Hashable, U>(_ f: @escaping (T) -> U) -> (T) -> U {
    var cache = [T : U]()
    
    return { key in
        var value = cache[key]
        if value == nil {
            value = f(key)
            cache[key] = value
        }
        return value!
    }
}
