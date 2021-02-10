//
//  PartyHomeViewModel.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

class PartyHomeViewModel: ViewModel {
    var socketService: SocketService!
    var partyId: String!
    var party: PartyData? {
        didSet {
            objectWillChange.send()
        }
    }

    var isHost: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }

    func sendNewPlayerEvent() {
        let params = PartyIdParameter(id: partyId)
        socketService.emit(event: .partyPlayerNew(params: params))
    }

    func subscribeToEvents() {
        socketService.subscribe(event: .partyPlayerJoin, callback: weakify { (strongSelf, data: PartyData) in
            strongSelf.party = data
            
            if data.host.id == strongSelf.socketService.getSocketId() {
                strongSelf.isHost = true
            }
        })
    }
}
