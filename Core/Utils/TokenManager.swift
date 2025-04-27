//
//  TokenManager.swift
//  StarNews
//
//  Created by daud daud on 27/04/25.
//

import Foundation
import SimpleKeychain

final class TokenManager {
    
    static let shared = TokenManager()
    
    private let keychain = A0SimpleKeychain(service: "Auth0")
    
    private init() { }
    
    func save(accessToken: String?, idToken: String?) {
        if let accessToken = accessToken {
            keychain.setString(accessToken, forKey: "access_token")
        }
        if let idToken = idToken {
            keychain.setString(idToken, forKey: "id_token")
        }
    }
    
    func getAccessToken() -> String? {
        return keychain.string(forKey: "access_token")
    }
    
    func getIdToken() -> String? {
        return keychain.string(forKey: "id_token")
    }
    
    func clear() {
        keychain.deleteEntry(forKey: "access_token")
        keychain.deleteEntry(forKey: "id_token")
    }
    
    func isLoggedIn() -> Bool {
        return getAccessToken() != nil
    }
}
