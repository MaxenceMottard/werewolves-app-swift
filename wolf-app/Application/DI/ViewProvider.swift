//
//  ViewProvider.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Swinject

class ViewProvider {
    static func generateAssembler(viewControllerAssembly: Assembly) -> Assembler {
        return Assembler([viewControllerAssembly, HelperAssembly()])
    }
}
