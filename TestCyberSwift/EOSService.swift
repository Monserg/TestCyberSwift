//
//  EOSService.swift
//  TestMyLib
//
//  Created by msm72 on 4/16/19.
//  Copyright © 2019 golos.io. All rights reserved.
//

import CyberSwift
import Foundation
import eosswift

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
                                        
                                        if let data = response.body?.processed.action_traces.first?.act.data, let messageID = data["message_id"], let json = messageID.jsonValue as? [String: AnyJSONType] {
                                            Logger.log(message: "json = \(json)", event: .debug)
                                            
                                            // Test action `upvote`
                                            if let permlinkData = json["permlink"], let permlinkValue = permlinkData.jsonValue as? String, let authorData = json["author"], let authorValue = authorData.jsonValue as? String {
                                                self.testMessage(voteActionType: .upvote, author: authorValue, permlink: permlinkValue)
                                            }
                                            
                                            
                                            // Test action `reblog`
//                                            self.testReblog(messageAuthor:          "tst2jejxypdx",
//                                                            messagePermlink:        "title2-2019-05-20t10-35-36",
//                                                            messageRefBlockNum:     893085,
//                                                            messageRebloger:        "tst2jejxypdx")
                                        }
        },
                                       errorHandling:       { (errorAPI) in
                                        Logger.log(message: errorAPI.caseInfo.message, event: .error)
        })
    }

    
    /// Action `updatemssg`
    func testUpdatePostMessage() {
        let messageAuthor: String           =   Config.testUserAccount.nickName
        let messagePermlink: String         =   "title2-2019-05-23t12-30-55"
        let messageParentData: ParentData?  =   nil
        let messageBody: String             =   "Updating body message for current \(messageParentData == nil ? "Post" : "Comment")..."
        
        RestAPIManager.instance.updateMessage(author: messageAuthor,
                                              permlink: messagePermlink,
                                              message: messageBody,
                                              parentData: messageParentData,
                                              responseHandling: { response in
                                                Logger.log(message: "response: \(response)", event: .debug)
        },
                                              errorHandling: { errorAPI in
                                                Logger.log(message: errorAPI.caseInfo.message, event: .error)
        })
    }
    
    
    /// Action `deletemssg`
    func testDeletePostMessage() {
        let postAuthor: String      =   Config.testUserAccount.nickName
        let postPermlink: String    =   "title2-2019-05-23t12-30-55"
        
        RestAPIManager.instance.deleteMessage(author:               postAuthor,
                                              permlink:             postPermlink,
                                              responseHandling:     { response in
                                                Logger.log(message: "response: \(response)", event: .debug)
        },
                                              errorHandling:        { errorAPI in
                                                Logger.log(message: errorAPI.caseInfo.message, event: .error)
        })
    }

    
    /// Actions `upvote`, `downvote`, `unvote`
    func testMessage(voteActionType: VoteActionType, author: String, permlink: String) {
        // 1. run 'testAuthorize()'
        // 2. run 'testCreatePostMessage()' -> get `permlink`
        RestAPIManager.instance.message(voteActionType:     voteActionType,
                                        author:             author,
                                        permlink:           permlink,
                                        responseHandling:   { response in
                                            Logger.log(message: "response: \(response)", event: .debug)
                                            
                                            // Test action `unvote`
                                            if voteActionType == .upvote {
                                                self.testMessage(voteActionType: .unvote, author: author, permlink: permlink)
                                            }
        },
                                        errorHandling:      { errorAPI in
                                            Logger.log(message: errorAPI.caseInfo.message, event: .error)
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
        
        RestAPIManager.instance.reg(witness:                witness,
                                    url:                    url,
                                    responseHandling:       { response in
                                        Logger.log(message: "response: \(response)", event: .debug)
        },
                                    errorHandling:          { errorAPI in
                                        Logger.log(message: errorAPI.caseInfo.message, event: .error)
        })
    }

    /// Action `votewitness` (2)
    func testVotewitness() {
        let voter: String       =   Config.testUserAccount.nickName
        let witness: String     =   Config.currentUser.nickName!
        
        Config.isPublicTestnet  =   true

        RestAPIManager.instance.vote(witness:               witness,
                                     voter:                 voter,
                                     responseHandling:      { response in
                                        Logger.log(message: "response: \(response)", event: .debug)
        },
                                     errorHandling:         { errorAPI in
                                        Logger.log(message: errorAPI.caseInfo.message, event: .error)
        })
    }
    
    /// Action `unvotewitn` (3)
    func testUnvotewitness() {
        let voter: String       =   Config.testUserAccount.nickName
        let witness: String     =   Config.currentUser.nickName!
        
        Config.isPublicTestnet  =   true
        
        RestAPIManager.instance.unvote(witness:             witness,
                                       voter:               voter,
                                       responseHandling:    { response in
                                        Logger.log(message: "response: \(response)", event: .debug)
        },
                                       errorHandling:       { errorAPI in
                                        Logger.log(message: errorAPI.caseInfo.message, event: .error)
        })
    }
    
    /// Action `unregwitness` (4)
    func testUnregwitness() {
        let witness: String     =   Config.currentUser.nickName!
        
        Config.isPublicTestnet  =   true
        
        RestAPIManager.instance.unreg(witness:              witness,
                                      responseHandling:     { response in
                                        Logger.log(message: "response: \(response)", event: .debug)
        },
                                      errorHandling:        { errorAPI in
                                        Logger.log(message: errorAPI.caseInfo.message, event: .error)
        })
    }
}
