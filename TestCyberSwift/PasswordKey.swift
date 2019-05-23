////
////  PasswordKey.swift
////  GoloSwift
////
////  Created by msm72 on 29.06.2018.
////  Copyright © 2018 golos. All rights reserved.
////
////  https://github.com/steemit/steem-python/blob/master/steembase/account.py
////  https://steemit.com/security/@noisy/public-and-private-keys-how-to-generate-all-steem-user-s-keys-from-master-password-without-a-steemit-website-being-offline
////
//
//import Foundation
//
//public enum AccountKeyType: String {
//    case active     =   "active"
//    case posting    =   "posting"
//    case memo       =   "memo"
//}
//
//
//public struct PasswordKey: Equatable {
//    // MARK: - Properties
//    public let nickName: String
//    public let password: String
//    public let keyType: String
//    
//    
//    // MARK: - Initialization
//    public init?(nickName: String, password: String, type: AccountKeyType) {
//        self.nickName = nickName
//        self.password = password
//        self.keyType = type.rawValue
//    }
//    
//    
//    // MARK: - Custom Functions
//    public func generatePrivateKey() -> PrivateKey? {
//        let bytes = (self.nickName + self.password + self.keyType).bytes
//        let digestBytes = bytes.sha256().toHexString()
//        
//        return PrivateKey.init(digestBytes)
//    }
//}
