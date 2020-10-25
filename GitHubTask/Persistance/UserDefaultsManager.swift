//
//  UserDefaultsManager.swift
//  GitHubTask
//
//  Created by Dejan on 24/10/2020.
//

import Foundation

protocol UserDefaultsManager {
    var accessToken: String? { set get }
}

class UserDefaultsManagerImpl: UserDefaultsManager {
    
    let userDefaults = UserDefaults.standard
    
    var accessToken: String? {
        get {
            if let token = userDefaults.string(forKey: "access_token") {
                return token
            }
            return nil
        }
        set {
            userDefaults.set(newValue, forKey: "access_token")
        }
    }
}
