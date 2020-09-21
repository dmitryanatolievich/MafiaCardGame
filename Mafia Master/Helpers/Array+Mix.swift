//
//  Array+Mix.swift
//  Mafia Master
//
//  Created by Dmitry Anatolievich on 09.03.2020.
//  Copyright © 2020 Rock'N'Rolla. All rights reserved.
//

import Foundation

extension Array where Element == CharacterType {
    mutating func randomMix() -> [CharacterType] {
        var oldArray = self
        var newArray: [CharacterType] = []
        while !oldArray.isEmpty {
            let randomIndex = Int.random(in: 0..<oldArray.count)
            newArray.append(oldArray.remove(at: randomIndex))
        }
        return newArray
    }
}
