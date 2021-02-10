//
//  PartyLobbyViewModel.swift
//  wolf-app
//
//  Created by Maxence Mottard on 10/02/2021.
//

class PartyLobbyViewModel: ViewModel {
    var socketService: SocketService!
    var party: PartyData!
    var isHost: Bool!

    func subscribeToEvents() {
        socketService.subscribe(event: .partyPlayerJoin, callback: weakify { (strongSelf, data: PartyData) in
//            strongSelf.party = data
        })
    }

    func handleStartParty() {
//        socketService.emit
    }
}
