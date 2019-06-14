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
//        for i in 11...15 {
//            DispatchQueue.main.async {
                RestAPIManager.instance.posting(image:              UIImage(named: "test-\(1)")!,
                                                responseHandling:   { response in
                                                    Logger.log(message: "response: \(response)", event: .debug)
                },
                                                errorHandling:      { errorAPI in
                                                    Logger.log(message: "error: \(errorAPI)", event: .error)
                })
//            }
//        }
    }
    
    /// Action `updatemeta`
    func testUpdatemeta() {
        /*
             personal.avatarUrl     = or(personal.avatarUrl, meta.profile_image);
             personal.coverUrl = or(personal.coverUrl, meta.cover_image);
             personal.biography = or(personal.biography, meta.about);
             contacts.facebook = or(contacts.facebook, meta.facebook);
             contacts.telegram = or(contacts.telegram, meta.telegram);
             contacts.whatsApp = or(contacts.whatsApp, '');
             contacts.weChat = or(contacts.weChat, '');
         */
        
        let paramsJSON  =   [
                                "facebook":         "testFacebook",
                                "telegram":         "testTelegram",
                                "about":            "testAbout",
                                "profile_image":    "https://img.golos.io/images/2GQyRK8zNYVcNkd3jQHpXurBDtDb.jpg",
                                "cover_image":      nil
                            ]


//        let paramsJSON  =   [
//                                "type":                 "типа",
//                                "app":                  nil,
//                                "email":                nil,
//                                "phone":                nil,
//                                "facebook":             nil,*
//                                "instagram":            nil,
//                                "telegram":             nil,*
//                                "vk":                   nil,
//                                "website":              nil,
//                                "first_name":           nil,
//                                "last_name":            nil,
//                                "name":                 nil,
//                                "birth_date":           nil,
//                                "gender":               nil,
//                                "location":             nil,
//                                "city":                 nil,
//                                "about":                nil,
//                                "occupation":           nil,
//                                "i_can":                nil,
//                                "looking_for":          nil,
//                                "business_category":    nil,
//                                "background_image":     nil,
//                                "cover_image":          nil,*
//                                "profile_image":        nil,*
//                                "user_image":           nil,
//                                "ico_address":          nil,
//                                "target_date":          nil,
//                                "target_plan":          nil,
//                                "target_point_a":       nil,
//                                "target_point_b":       nil
//                            ]

        
        RestAPIManager.instance.update(userProfile:         paramsJSON,
                                       responseHandling:    { response in
                                        Logger.log(message: "response: \(response)", event: .debug)
                                        
                                        
                                        /// API `content.waitForTransaction`
                                        if let trxID = response.body?.transaction_id {
                                            RestAPIManager.instance.waitForTransactionWith(id:          trxID,
                                                                                           completion:  { errorAPI in
                                                                                            if errorAPI == nil {
                                                                                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                                                                                                    FacadeService().testGetProfile()
                                                                                                })
                                                                                            }
                                            })

                                        }
        },
                                       errorHandling:      { errorAPI in
                                        Logger.log(message: "error: \(errorAPI)", event: .error)
        })
    }

    
    //  MARK: - Contract `gls.publish`
    /// Action `createmssg`, create new post
    func testCreatePostMessage() {
        let testImage: String               =   "{\"type\":\"photo\",\"id\":\(Date().generateCurrentTimeStamp()),\"url\":\"https:\\/\\/img.golos.io\\/images\\/gUmGAM4T5AyoqsV7DgWVz11wMHQ.jpg\"}"
        let testTitle: String               =   "Photos title 117"
        let testTags: [String]?             =   ["jfks", "sfndkl"]
        let testMetaData: String            =   "{\"embeds\": [\(testImage)]}"
//        let testMetaData: String            =   "{\"embeds\": [\(testImage),{\"url\":\"https:\\/\\/Vc.ru\"}]}"
        let testMessage: String             =   "Jvhukijlk;mknbjvftg7lyijknbafgudyhkjbg adds #jfks #sfndkl https://vc.ru"
        
        RestAPIManager.instance.create(message:             testMessage,
                                       headline:            testTitle,
                                       tags:                testTags,
                                       metaData:            testMetaData,
                                       responseHandling:    { response in
                                        Logger.log(message: "response: \(response)", event: .debug)
                                        
                                        if  let data        =   response.body?.processed.action_traces.first?.act.data,
                                            let messageID   =   data["message_id"],
                                            let json        =   messageID.jsonValue as? [String: AnyJSONType] {
                                            Logger.log(message: "json = \(json)", event: .debug)
                                            
                                            // Test action `createmssg`, create new comment
                                            if let permlinkData = json["permlink"], let permlinkValue = permlinkData.jsonValue as? String {
                                                Logger.log(message: "permlinkValue = \(permlinkValue), testTags = \(testTags!)", event: .debug)
                                                self.testCreateCommentMessage(parentPermlink: permlinkValue, tags: testTags!)
                                            }
                                            
                                            /*
                                            if let authorData = json["author"], let authorValue = authorData.jsonValue as? String {
                                                // Test action `upvote`
                                                self.testMessage(voteActionType: .upvote, author: authorValue, permlink: permlinkValue)
                                             
                                                // Test action `reblog`
                                                self.testMessageReblog(author:      authorValue,
                                                                       permlink:    permlinkValue,
                                                                       rebloger:    "tst1kfzmmlqi",
                                                                       title:       "Reblog title #1",
                                                                       body:        "Reblog body message #1")
                                            }
                                            */
                                        }
        },
                                       errorHandling:       { (errorAPI) in
                                        Logger.log(message: errorAPI.caseInfo.message, event: .error)
        })
    }

    
    /// Action `createmssg`, create new comment
    func testCreateCommentMessage(parentPermlink: String, tags: [String]) {
        let testTitle: String       =   "Comment Title \(arc4random_uniform(200))"
        let testMessage: String     =   "Comment Message \(arc4random_uniform(200))"
        
        RestAPIManager.instance.create(message:             testMessage,
                                       headline:            testTitle,
                                       parentPermlink:      parentPermlink,
                                       tags:                tags,
                                       metaData:            "nil",
                                       responseHandling:    { response in
                                        Logger.log(message: "response: \(response)", event: .debug)
        },
                                       errorHandling:       { (errorAPI) in
                                        Logger.log(message: errorAPI.caseInfo.message, event: .error)
        })
    }

    
    /// Action `updatemssg`
    func testUpdatePostMessage() {
        let messageAuthor: String           =   Config.testUserAccount.nickName
        let messagePermlink: String         =   "title2-2019-05-23t12-30-55"
        let messageParentPermlink: String?  =   nil
        let messageBody: String             =   "Updating body message for current \(messageParentPermlink == nil ? "Post" : "Comment")..."
        
        RestAPIManager.instance.updateMessage(author:               messageAuthor,
                                              permlink:             messagePermlink,
                                              message:              messageBody,
                                              parentPermlink:       messageParentPermlink,
                                              responseHandling:     { response in
                                                Logger.log(message: "response: \(response)", event: .debug)
        },
                                              errorHandling:        { errorAPI in
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
    // 1. run 'testAuthorize()'
    // 2. run 'testCreatePostMessage()' -> get `permlink`, `author`
    func testMessageReblog(author:      String,
                           permlink:    String,
                           rebloger:    String,
                           title:       String,
                           body:        String) {
        RestAPIManager.instance.reblogMessage(author:               author,
                                              rebloger:             rebloger,
                                              permlink:             permlink,
                                              headermssg:           title,
                                              bodymssg:             body,
                                              responseHandling:     { response in
                                                Logger.log(message: "response: \(response)", event: .debug)
        },
                                              errorHandling:        { errorAPI in
                                                Logger.log(message: errorAPI.caseInfo.message, event: .error)
        })
    }


    //  MARK: - Contract `gls.ctrl`
    /// Action `regwitness` (1)
    func testRegwitness() {
        let witness: String     =   Config.currentUser.nickName!
        let url: String         =   String.randomString(length: 20)
        
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
        
        RestAPIManager.instance.unreg(witness:              witness,
                                      responseHandling:     { response in
                                        Logger.log(message: "response: \(response)", event: .debug)
        },
                                      errorHandling:        { errorAPI in
                                        Logger.log(message: errorAPI.caseInfo.message, event: .error)
        })
    }
}
