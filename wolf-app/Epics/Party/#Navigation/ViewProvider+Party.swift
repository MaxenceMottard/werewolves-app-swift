//
//  ViewProvider+Party.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

extension ViewProvider {
    static func party(id partyId: String) -> PartyView {
        let assembler = generateAssembler(viewControllerAssembly: PartyAssembly())
        return assembler.resolver.resolve(PartyView.self, argument: partyId)!
    }
}
