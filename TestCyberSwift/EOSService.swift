//
//  EOSService.swift
//  TestMyLib
//
//  Created by msm72 on 4/16/19.
//  Copyright © 2019 golos.io. All rights reserved.
//

import CyberSwift
import Foundation

struct EOSService {
    //  MARK: - Contract `gls.social`
    /// Posting image
    func testPostingImage() {
        RestAPIManager.instance.posting(image:              UIImage(named: "volvo")!,
                                        responseHandling:   { response in
                                            Logger.log(message: "response: \(response)", event: .debug)
        },
                                        errorHandling:      { errorAPI in
                                            Logger.log(message: "error: \(errorAPI)", event: .error)
        })
    }
    

    //  MARK: - Contract `gls.publish`
    /// Action `createmssg`
    func testCreatePostMessage() {
        let testTitle: String       =   "Title2" // "Post theme"
        let testTags: [String]?     =   ["#jfks", "#sfndkl"] // ["#vk", "#insta", "#vc"]
        let testMetaData: String?   =   "{\"embeds\":[{\"url\":\"https:\\/\\/Vc.ru\"}]}" // "{\"embeds\":[{\"url\":\"https:\\/\\/Vc.ru\"}]}"
//        let testMessage: String     =   "I’m reading #vk #insta and #vc\nHttp://Vk.com https://vc.ru"
        let testMessage: String     =   "Jvhukijlk;mknbjvftg7lyijknbafgudyhkjbg adds #jfks #sfndkl https://vc.ru" // "I’m reading #vk #insta and #vc\nHttp://Vk.com https://vc.ru"
        
        RestAPIManager.instance.create(message:             testMessage,
                                       headline:            testTitle,
                                       tags:                testTags,
                                       metaData:            testMetaData,
                                       responseHandling:    { (response) in
                                        Logger.log(message: "response: \(response)", event: .debug)
                                        
                                        if let data = response.body?.processed.action_traces.first?.act.data, let messageID = data["message_id"], let json = messageID.jsonValue as? [String: Any] {
                                            Logger.log(message: "json = \(json)", event: .debug)
                                            
                                            // Test action `reblog`
//                                            self.testReblog(messageAuthor:          "tst2jejxypdx",
//                                                            messagePermlink:        "title2-2019-05-20t10-35-36",
//                                                            messageRefBlockNum:     893085,
//                                                            messageRebloger:        "tst2jejxypdx")
                                        }
        },
                                       errorHandling:       { (errorAPI) in
                                        Logger.log(message: "error.caseInfo.message", event: .error)
        })
    }

    
    /// Action `reblog`
    func testReblog(messageAuthor:          String,
                    messagePermlink:        String,
                    messageRebloger:        String) {
        RestAPIManager.instance.reblog(author:              messageAuthor,
                                       rebloger:            messageRebloger,
                                       permlink:            messagePermlink,
                                       responseHandling:    { (response) in
                                        print(response)
        },
                                       errorHandling:       { (errorAPI) in
                                        print(errorAPI)
        })
    }


    //  MARK: - Contract `gls.ctrl`
    /// Action `regwitness` (1)
    func testRegwitness() {
        let witness: String     =   Config.currentUser.nickName!
        let url: String         =   String.randomString(length: 20)

        Config.isPublicTestnet  =   true
        
        RestAPIManager.instance.reg(witness:        witness,
                                    url:            url,
                                    completion:     { (response, error) in
                                        guard error == nil else {
                                            print(error!.caseInfo.message)
                                            return
                                        }
                                        
                                        print(response!.statusCode)
                                        print(response!.success)
                                        print(response!.body!)
        })
    }

    /// Action `votewitness` (2)
    func testVotewitness() {
        let voter: String       =   Config.testUserAccount.nickName
        let witness: String     =   Config.currentUser.nickName!
        
        Config.isPublicTestnet  =   true

        RestAPIManager.instance.vote(witness:       witness,
                                     voter:         voter,
                                     completion:    { (response, error) in
                                                guard error == nil else {
                                                    print(error!.caseInfo.message)
                                                    return
                                                }
                                                
                                                print(response!.statusCode)
                                                print(response!.success)
                                                print(response!.body!)
        })
    }
    
    /// Action `unvotewitn` (3)
    func testUnvotewitness() {
        let voter: String       =   Config.testUserAccount.nickName
        let witness: String     =   Config.currentUser.nickName!
        
        Config.isPublicTestnet  =   true
        
        RestAPIManager.instance.unvote(witness:       witness,
                                       voter:         voter,
                                       completion:    { (response, error) in
                                        guard error == nil else {
                                            print(error!.caseInfo.message)
                                            return
                                        }
                                        
                                        print(response!.statusCode)
                                        print(response!.success)
                                        print(response!.body!)
        })
    }
    
    /// Action `unregwitness` (4)
    func testUnregwitness() {
        let witness: String     =   Config.currentUser.nickName!
        
        Config.isPublicTestnet  =   true
        
        RestAPIManager.instance.unreg(witness:      witness,
                                      completion:   { (response, error) in
                                        guard error == nil else {
                                            print(error!.caseInfo.message)
                                            return
                                        }
                                        
                                        print(response!.statusCode)
                                        print(response!.success)
                                        print(response!.body!)
        })
    }
}
