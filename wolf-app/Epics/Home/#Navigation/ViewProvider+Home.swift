//
//  ViewProvider+JoinParty.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

extension ViewProvider {
    static func home() -> HomeView {
        let assembler = generateAssembler(viewControllerAssembly: HomeAssembly())
        return assembler.resolver.resolve(HomeView.self)!
    }
}
