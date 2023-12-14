//
//  LoginUserHashCache.swift
//  Coogle
//
//  Created by jh on 2023/02/26.
//

import Foundation

struct LoginUserHashCache {
    static let shared = LoginUserHashCache()
    private init () {}
    var loginKey = "UserHashKey"
    
    func check() -> String? {
        if let userHash = UserDefaults.standard.object(forKey: loginKey) as? String {
            return userHash
        }
        return nil
    }
    
    func store(value: String){
        UserDefaults.standard.set(value, forKey: loginKey)
    }
    
    func logout(){
        UserDefaults.standard.removeObject(forKey: loginKey)
    }
}
