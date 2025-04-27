//
//  LoginViewModel.swift
//  StarNews
//
//  Created by daud daud on 27/04/25.
//
import Auth0
import SimpleKeychain

class LoginViewModel {
    
//    func login(completion: @escaping (Bool) -> Void) {
//        Auth0
//            .webAuth()
//            .scope("openid profile email")
//            .audience("https://dev-4wwmbpwyfz45o3xa.us.auth0.com/userinfo")
//            .start { result in
//                switch result {
//                case .success(let credentials):
//                    print("✅ Access Token: \(credentials.accessToken ?? "")")
//                    // Simpan token jika perlu
//                    completion(true)
//                case .failure(let error):
//                    print("❌ Auth0 Login Error: \(error)")
//                    completion(false)
//                }
//            }
//    }
    
//    func login(completion: @escaping (Bool) -> Void) {
//        Auth0
//        .webAuth(clientId: Auth0Constants.clientId, domain: Auth0Constants.domain)
//        .start { result in
//            switch result {
//            case .success(let credentials):
//                print("Access Token: \(credentials.accessToken ?? "")")
//                // Simpan token kalau perlu, pindah ke halaman utama, dll.
//            case .failure(let error):
//                print("Login failed: \(error)")
//            }
//        }
//    }
    
    func login(completion: @escaping (Bool) -> Void) {
        Auth0
        .webAuth()
        .start { result in
            switch result {
            case .success(let credentials):
                print("Access Token: \(credentials.accessToken ?? "")")
                
                // Simpan token ke keychain menggunakan TokenManager
                TokenManager.shared.save(accessToken: credentials.accessToken, idToken: credentials.idToken)
                
                completion(true)
            case .failure(let error):
                print("Login failed: \(error)")
                completion(false)
            }
        }
    }
    
}
