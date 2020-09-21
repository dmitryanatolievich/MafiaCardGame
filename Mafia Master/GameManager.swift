//
//  GameManager.swift
//  Mafia Master
//
//  Created by Dmitry Anatolievich on 09.03.2020.
//  Copyright © 2020 Rock'N'Rolla. All rights reserved.
//

class GameManager {
    static var gameManager: GameManager = GameManager()
    var numberOfPlayers: Int = 0
    var characters: [CharacterType] = []
    private init() {
    }
}
