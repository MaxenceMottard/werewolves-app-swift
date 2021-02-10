//
//  ViewProvider+JoinParty.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

extension ViewProvider {
    static func joinParty() -> JoinPartyView {
        let assembler = generateAssembler(viewControllerAssembly: JoinPartyAssembly())
        return assembler.resolver.resolve(JoinPartyView.self)!
    }
}
