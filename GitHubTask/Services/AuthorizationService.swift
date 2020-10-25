//
//  AuthorizationService.swift
//  GitHubTask
//
//  Created by Dejan on 23/10/2020.
//

import Foundation
import Combine
import SwiftUI

protocol AuthorizationService {
    func accessToken(code: String) -> AnyPublisher<AccessToken, Error>
    func user(token: String) -> AnyPublisher<Author, Error>
}

class AuthorizationServiceImpl: AuthorizationService, WebRepository {
    
    var session = ApiConfig.configuredURLSession()
    let cancelBag = CancelBag()
    
    func accessToken(code: String) -> AnyPublisher<AccessToken, Error> {
        call(endpoint: ApiEndpoint.accessToken(code: code))
    }
    func user(token: String) -> AnyPublisher<Author, Error> {
        call(endpoint: ApiEndpoint.user(token: token))
    }
}
