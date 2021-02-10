//
//  CreatePartyParameter.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

struct CreatePartyParameter: SocketParameter {
    let username: String

    var dictionary: [String : Any] {
        [ "username": username ]
    }
}
