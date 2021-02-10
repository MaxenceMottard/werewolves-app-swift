//
//  PartyViewModel.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Foundation

class PartyViewModel: ViewModel {
    var socketService: SocketService!
    var partyId: String!
    var party: PartyData?

    func sendNewPlayerEvent() {
        let params = PartyIdParameter(id: partyId)
        socketService.emit(event: .partyPlayerNew(params: params))
    }

    func subscribeToEvents() {
        socketService.subscribe(event: .partyPlayerJoin, callback: weakify { (strongSelf, data: PartyData) in
            strongSelf.party = data
        })
    }
}
