//
//  ViewError.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Foundation


struct ViewError: Error, Identifiable {
    let errorCode: ErrorCode
    var id: String { errorCode.rawValue }

    var title: String {  NSLocalizedString("error.alert.\(errorCode).title", comment: "") }
    var description: String {  NSLocalizedString("error.alert.\(errorCode).description", comment: "") }

    enum ErrorCode: String {
        case PARTY_REFUSED
    }
}
