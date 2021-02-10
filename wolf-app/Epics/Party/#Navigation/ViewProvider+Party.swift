//
//  ViewProvider+Party.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

extension ViewProvider {
    enum Party {
        static func home(id partyId: String) -> PartyHomeView {
            let assembler = generateAssembler(viewControllerAssembly: PartyHomeAssembly())
            return assembler.resolver.resolve(PartyHomeView.self, argument: partyId)!
        }

        static func lobby(with party: PartyData, _ isHost: Bool) -> PartyLobbyView {
            let assembler = generateAssembler(viewControllerAssembly: PartyLobbyAssembly())
            return assembler.resolver.resolve(PartyLobbyView.self, arguments: party, isHost)!
        }
    }
}
