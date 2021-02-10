//
//  AnyEncodable.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

struct AnyEncodable: Encodable {

    private let encodable: Encodable

    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
