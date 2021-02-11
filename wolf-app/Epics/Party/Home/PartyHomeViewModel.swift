//
//  PartyHomeViewModel.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import SwiftUI

class PartyHomeViewModel: ViewModel {
    @AppStorage("username") var username: String = ""

    var socketService: SocketService!
    var partyId: String!
    var party: PartyData? {
        didSet {
            objectWillChange.send()
        }
    }

    var isHost: Bool = false

    func sendNewPlayerEvent() {
        let params = JoinPartyParameter(id: partyId, username: username)
        socketService.emit(event: .partyJoin(params: params))
    }

    func subscribeToEvents() {
        socketService.subscribe(event: .partyInfo, callback: weakify { (strongSelf, data: PartyData) in
            strongSelf.isHost = (data.host.id == strongSelf.socketService.getSocketId())
            strongSelf.party = data
        })

        socketService.subscribe(event: .partyRefused, callback: weakify { (strongSelf, _: PartyIdData) in
            strongSelf.handleError(error: ViewError(errorCode: .PARTY_REFUSED))
            ViewProvider.shared.setEntrypoint(.home)
        })
    }
}
