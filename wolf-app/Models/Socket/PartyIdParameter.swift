//
//  PartyIdParameter.swift
//  wolf-app
//
//  Created by Maxence Mottard on 10/02/2021.
//

struct PartyIdParameter: SocketParameter {
    let id: String

    var dictionary: [String: Any] {
        get {
            ["id": id ]
        }
    }
}
