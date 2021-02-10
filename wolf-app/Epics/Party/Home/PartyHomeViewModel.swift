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

    var isHost: Bool = false

    func sendNewPlayerEvent() {
        let params = PartyIdParameter(id: partyId)

        if socketService.isConnected {
            socketService.emit(event: .partyPlayerNew(params: params))
        } else {
            socketService.connect()
            socketService.subscribe(event: .userId, callback: weakify { (strongSelf, _: UserIdData) in
                strongSelf.socketService.emit(event: .partyPlayerNew(params: params))
            })
        }
    }

    func subscribeToEvents() {
        socketService.subscribe(event: .partyPlayerJoin, callback: weakify { (strongSelf, data: PartyData) in
            strongSelf.isHost = (data.host.id == strongSelf.socketService.getSocketId())
            strongSelf.party = data
        })

        socketService.subscribe(event: .partyRefused) { (_: PartyIdData) in
            ViewProvider.shared.setEntrypoint(.home)
        }
    }
}
