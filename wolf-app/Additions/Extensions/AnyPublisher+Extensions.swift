//
//  AnyPublisher+Extensions.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Combine

extension AnyPublisher {
    
    static func empty() -> AnyPublisher {
        return AnyPublisher(Empty())
    }
    
}
