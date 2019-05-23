//
//  RegistrationService.swift
//  TestMyLib
//
//  Created by msm72 on 4/11/19.
//  Copyright © 2019 golos.io. All rights reserved.
//

import CyberSwift
import Foundation

struct RegistrationService {
    // Test API `registration.getState`
    func testGetState(phone: String) {
        let userNickName: String?   =   nil // Config.accountNickTest
        
        RestAPIManager.instance.getState(nickName:          userNickName,
                                         phone:             phone,
                                         responseHandling:  { state in
                                            Logger.log(message: "Response state: \n\t\(state)", event: .debug)
        },
                                         errorHandling:     { errorAPI in
                                            Logger.log(message: "Response errorAPI: \n\t\(errorAPI.caseInfo.message)", event: .error)
        })
        
        
//        let currentState = RestAPIManager.instance.getState(nickName:      userNickName,
//                                                            phone:         phone)
//            .map({ result -> String in
//                Logger.log(message: "Response: \n\t\(result.currentState)", event: .debug)
//                return result.currentState
//            })
//
//        Logger.log(message: "currentState: \n\t\(currentState)", event: .debug)
    }

    // Test API `registration.firstStep`
//    func testFirstStep(phone: String) {
//        RestAPIManager.instance.firstStep(phone:        phone,
//                                          completion:   { (result, errorAPI) in
//                                            guard errorAPI == nil else {
//                                                Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
//                                                return
//                                            }
//
//                                            Logger.log(message: "Response: \n\t\(result!)", event: .debug)
//
//                                            self.testVerify(phone: phone, code: String(describing: result!.code))
////                                            self.resendSmsCode(phone: userPhoneValue)
//        })
//    }
    
    // Test API `registration.verify`
//    func testVerify(phone: String, code: String) {
//        let isDebugMode: Bool   =   appBuildConfig == AppBuildConfig.debug
//
//        RestAPIManager.instance.verify(phone:           phone,
//                                       code:            code,
//                                       isDebugMode:     isDebugMode,
//                                       completion:      { (result, errorAPI) in
//                                        guard errorAPI == nil else {
//                                            Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
//                                            return
//                                        }
//
//                                        Logger.log(message: "Response: \n\t\(result!.status)", event: .debug)
//
//                                        self.testSetUser(nickName: "testUser3", phone: phone)
//        })
//    }
    
    // Test API `registration.setUsername`
//    private func testSetUser(nickName: String, phone: String) {
//        let isDebugMode: Bool   =   appBuildConfig == AppBuildConfig.debug
//
//        RestAPIManager.instance.setUser(name:           nickName,
//                                        phone:          phone,
//                                        isDebugMode:    isDebugMode,
//                                        completion:     { (result, errorAPI) in
//                                            guard errorAPI == nil else {
//                                                Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
//                                                return
//                                            }
//
//                                            Logger.log(message: "Response: \n\t\(result!.status)", event: .debug)
//
//                                            self.testToBlockChain(nickName: nickName)
//        })
//    }
    
    // Test API `registration.resendSmsCode`
//    func resendSmsCode(phone: String) {
//        let isDebugMode: Bool   =   appBuildConfig == AppBuildConfig.debug
//
//        RestAPIManager.instance.resendSmsCode(phone:        phone,
//                                              isDebugMode:  isDebugMode,
//                                              completion:   { (result, errorAPI) in
//                                                guard errorAPI == nil else {
//                                                    Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
//                                                    return
//                                                }
//
//                                                Logger.log(message: "Response: \n\t\(result!.code)", event: .debug)
//        })
//    }
    
    // Test API `registration.toBlockChain`
//    func testToBlockChain(nickName: String) {
//        RestAPIManager.instance.toBlockChain(nickName:      nickName,
//                                             completion:    { (result, errorAPI) in
//                                                guard errorAPI == nil else {
//                                                    Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
//                                                    return
//                                                }
//                                                
//                                                Logger.log(message: "Response: \n\t\(result.description)", event: .debug)
//        })
//    }
}
