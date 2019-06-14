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
    func testFirstStep(phone: String) {
            RestAPIManager.instance.firstStep(phone:                phone,
                                              responseHandling:     { response in
                                                Logger.log(message: "Response: \n\t\(response)", event: .debug)
                                                self.testVerify(phone: phone, code: String(describing: response.code))
//                                            self.resendSmsCode(phone: phone)
        },
                                          errorHandling:            { errorAPI in
                                            Logger.log(message: errorAPI.message.localized(), event: .error)
        })
    }
    
    // Test API `registration.verify`
    func testVerify(phone: String, code: String) {
        RestAPIManager.instance.verify(phone:               phone,
                                       code:                code,
                                       isDebugMode:         true,
                                       responseHandling:    { response in
                                        Logger.log(message: "Response: \n\t\(response.status)", event: .debug)
                                        self.testSetUser(nickName: "testuser8", phone: phone)
        },
                                       errorHandling:       { errorAPI in
                                        Logger.log(message: errorAPI.message.localized(), event: .error)
        })
    }
    
    // Test API `registration.setUsername`
    func testSetUser(nickName: String, phone: String) {
        RestAPIManager.instance.setUser(nickName:           nickName,
                                        phone:              phone,
                                        responseHandling:   { response in
                                            Logger.log(message: "Response: \n\t\(response.status)", event: .debug)
                                            self.testToBlockChain(nickName: nickName, phone: phone)
        },
                                        errorHandling:      { errorAPI in
                                            Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
        })
    }
    
    // Test API `registration.resendSmsCode`
    func resendSmsCode(phone: String) {
        RestAPIManager.instance.resendSmsCode(phone:                phone,
                                              isDebugMode:          true,
                                              responseHandling:     { response in
                                                Logger.log(message: "Response: \n\t\(response.code)", event: .debug)
                                                self.testVerify(phone: phone, code: "9999")
        },
                                              errorHandling:        { errorAPI in
                                                Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
        })
    }
    
    // Test API `registration.toBlockChain`
    func testToBlockChain(nickName: String, phone: String) {
        RestAPIManager.instance.toBlockChain(nickName:      nickName,
                                             phone:         phone,
                                             responseHandling:   { response in
                                                Logger.log(message: "Response: \n\t\(response)", event: .debug)
        },
                                             errorHandling:      { errorAPI in
                                                Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
        })
    }
}
