//
//  HelperAssembly.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Swinject
import SwinjectAutoregistration

class HelperAssembly: Assembly {
    func assemble(container: Container) {
        registerServices(container)
        registerWebServices(container)
    }
    
    func registerServices(_ container: Container) {
        container.register(SocketService.self) { _ -> SocketService in
            SocketService.shared
        }
        container.register(ViewProvider.self) { _ -> ViewProvider in
            ViewProvider.shared
        }
    }
    
    func registerWebServices(_ container: Container) {
    }
}
