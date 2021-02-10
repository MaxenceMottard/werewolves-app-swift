//
//  PartyData.swift
//  wolf-app
//
//  Created by Maxence Mottard on 10/02/2021.
//

import Foundation

struct Player: Decodable {
    let username: String
    let id: String
}

struct PartyData: Decodable {
    let id: String
    let players: [Player]
    let host: Player
    let isStarted: Bool
}
