//
//  RegisterViewModel.swift
//  StarNews
//
//  Created by daud daud on 27/04/25.
//

import Auth0

class RegisterViewModel {
    func register(completion: @escaping (Bool) -> Void) {
        Auth0
        .webAuth()
        .parameters(["screen_hint": "signup"]) // ini rahasianya!
        .start { result in
            switch result {
            case .success(let credentials):
                print("Access Token: \(credentials.accessToken ?? "")")
                
                // Simpan token ke keychain menggunakan TokenManager
                TokenManager.shared.save(accessToken: credentials.accessToken, idToken: credentials.idToken)
                
                completion(true)
            case .failure(let error):
                print("Register failed: \(error)")
                completion(false)
            }
        }
    }
}
