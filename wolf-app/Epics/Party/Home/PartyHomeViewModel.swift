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
        socketService.emit(event: .partyPlayerNew(params: params))
    }

    func subscribeToEvents() {
        socketService.subscribe(event: .partyPlayerJoin, callback: weakify { (strongSelf, data: PartyData) in
            strongSelf.isHost = (data.host.id == strongSelf.socketService.getSocketId())
            strongSelf.party = data
        })

        socketService.subscribe(event: .partyRefused, callback: weakify { (strongSelf, _: PartyIdData) in
            strongSelf.handleError(error: ViewError(errorCode: "GAME_REFUSED"))
            ViewProvider.shared.setEntrypoint(.home)
        })
    }
}
