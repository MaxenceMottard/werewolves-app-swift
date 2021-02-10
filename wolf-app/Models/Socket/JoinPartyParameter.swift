//
//  JoinParty.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

struct JoinPartyParameter: SocketParameter {
    let id: String
    let username: String

    var dictionary: [String: Any] {
        get {
            ["id": id, "username": username]
        }
    }
}
