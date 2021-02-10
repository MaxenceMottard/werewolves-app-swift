//
//  SocketClient.swift
//  wolf-app
//
//  Created by Maxence Mottard on 02/02/2021.
//

import Foundation
import SocketIO

class SocketService: Weakable {
    private let url = URL(string: PlistFiles.serverUrl)!
    private let manager: SocketManager
    private let client: SocketIOClient
    private var socketId: String!

    static let shared = SocketService()

    init() {
        manager = SocketManager(socketURL: url, config: [.log(false), .reconnects(true)])
        client = manager.defaultSocket

        subscribe(event: .userId, callback: weakify { (strongSelf, data: UserIdData) in
            strongSelf.socketId = data.userId
        })
    }

    func getSocketId() -> String! {
        return socketId
    }
    
    func connect() {
        client.connect()
    }
    
    func emit(event: EmitEvent) {
        switch event {
        case .partyCreate(let params as SocketParameter),
             .partyPlayerNew(let params as SocketParameter),
             .partyJoin(let params as SocketParameter) :
            client.emit(event.key, params.dictionary)
        default:
            client.emit(event.key)
        }
    }

    func subscribe<T: Decodable>(event: SubscribeEvent, callback: @escaping (T) -> Void) {
        client.on(event.rawValue) { result, _ in
            if let dataString = result.first as? String,
               let data = dataString.data(using: .utf8) {
                let decodedDdata = try! JSONDecoder().decode(T.self, from: data)

                callback(decodedDdata)
            } else {
                fatalError("Data return not JSON")
            }
        }
    }
    
    enum EmitEvent {
        case partyCreate(params: CreatePartyParameter)
        case partyJoin(params: JoinPartyParameter)
        case partyPlayerNew(params: PartyIdParameter)
        case roomsList

        var key: String {
            switch self {
            case .partyCreate:
                return "party:create"
            case .partyJoin:
                return "party:join"
            case .partyPlayerNew:
                return "party:player:new"
            case .roomsList:
                return "rooms:list"
            }
        }
    }

    enum SubscribeEvent: String {
        case userId = "user:id"
        case partyJoined = "party:joined"
        case partyRefused = "party:refused"
        case partyPlayerJoin = "party:player:join"
        case roomsList = "rooms:list"
        case connect = "connect"
    }
}
