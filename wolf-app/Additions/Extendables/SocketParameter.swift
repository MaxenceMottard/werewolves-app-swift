//
//  SocketParameter.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Foundation

protocol SocketParameter {
    var dictionary: [String: Any] { get }
}

//fileprivate struct EmptyParameter: SocketParameter {
//    var dictionary: [String: Any] = [:]
//}
//
//extension SocketParameter {
//    static func Empty() -> SocketParameter {
//        return EmptyParameter()
//    }
//}
