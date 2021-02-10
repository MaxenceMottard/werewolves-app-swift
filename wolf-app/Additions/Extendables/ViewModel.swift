//
//  ViewModel.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Foundation
import Combine
import SwiftUI

struct EmptyParameters: Encodable {}
struct EmptyResponse: Decodable {}

open class ViewModel: ObservableObject, Weakable {
    var bag = Set<AnyCancellable>()
    var error: ViewError?
    
    func executeRequest<T: WebService>(_ serviceSetup: ExecuteServiceSetup<T>, onSuccess: @escaping ((T.DecodedType) -> Void), onError: ((Error) -> Void)? = nil) {
        serviceSetup.service
            .call(serviceSetup.parameters, urlParameters: serviceSetup.urlParameters)
            .sink(receiveCompletion: weakify { strongSelf, result in
                switch result {
                case .finished:
                    break;
                case .failure(let error as ViewError):
                    guard let executeOnError = onError else {
                        return strongSelf.handleError(error: error)
                    }

                    executeOnError(error)
                case .failure(_):
//                    strongSelf.handleError(error: ViewError())
                    return
                }
            }, receiveValue: { value in
                onSuccess(value)
            }).store(in: &bag)
    }
    
    func executeRequestWithoutDecode<T: WebService>(_ serviceSetup: ExecuteServiceSetup<T>, onSuccess: @escaping (() -> Void), onError: ((Error) -> Void)? = nil) {
        serviceSetup.service
            .callWithoutDecode(serviceSetup.parameters, urlParameters: serviceSetup.urlParameters)
            .sink(receiveCompletion: weakify { strongSelf, result in
                switch result {
                case .finished:
                    break;
                case .failure(let error as ViewError):
                    guard let executeOnError = onError else {
                        return strongSelf.handleError(error: error)
                    }

                    executeOnError(error)
                case .failure(_):
//                    strongSelf.handleError(error: ViewError())
                    return
                }
            }, receiveValue: {
                onSuccess()
            }).store(in: &bag)
    }

    func handleError(error: ViewError) {
        ErrorProvider.shared.handleError(error)
    }
    
    struct ExecuteServiceSetup<T: WebService> {
        let service: T
        let parameters: T.ServiceParameters
        let urlParameters: [String] = []
    }
}

