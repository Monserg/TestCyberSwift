//
//  FacadeService.swift
//  TestMyLib
//
//  Created by msm72 on 4/12/19.
//  Copyright © 2019 golos.io. All rights reserved.
//

import CyberSwift
import Foundation

struct FacadeService {
    /// API `auth.authorize`
    //  1. run after get `sign` websocket secret key
    func testAuthorize() {
        if KeychainManager.deleteData(forUserNickName: Config.currentUserNameKey, withKey: Config.currentUserNameKey) {
            if KeychainManager.deleteData(forUserNickName: Config.currentUserPublicActiveKey, withKey: Config.currentUserPublicActiveKey) {
                Logger.log(message: "Success!!!", event: .debug)
            }
        }
        
        Broadcast.instance.generateNewTestUser { success in
            if success {
                RestAPIManager.instance.authorize(userID:               Config.testUser.id ?? "CyberSwift",
                                                  userActiveKey:        Config.testUser.activeKey ?? "CyberSwift",
                                                  responseHandling:     { response in
                                                    Logger.log(message: "API `auth.authorize` permission: \(response.permission)", event: .debug)
                                                    
                                                    /// Test API `push.historyFresh`
                                                    // self.testGetPushHistoryFresh()
                },
                                                  errorHandling:        { errorAPI in
                                                    Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
                })
            }
        }
    }
    

    /// Test API `content.getFeed`
    func testGetFeed() {
        let userID: String                  =   Config.currentUser.id ?? Config.testUser.id ?? "CyberSwift"
        let paginationSequenceKey: String?  =   nil //"58098388-437f-43f1-980c-8e363b5859a9|20"
        
        RestAPIManager.instance.loadFeed(typeMode:                  .community,
                                         userID:                    userID,
                                         communityID:               "gls",
                                         timeFrameMode:             .all,
                                         sortMode:                  .popular,
                                         paginationSequenceKey:      paginationSequenceKey,
                                         completion:                 { (feed, errorAPI) in
                                            guard errorAPI == nil else {
                                                Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
                                                return
                                            }
                                            
                                            guard feed?.sequenceKey != nil else {
                                                Logger.log(message: "Feed is finished.", event: .error)
                                                return
                                            }
                                            
                                            Logger.log(message: "Response: \n\t\(feed!.items!)", event: .debug)
        })
    }
    

    /// Test API `content.getPost`
    func testGetPost() {
        // 1. run API 'content.getFeed`
        // 2. get `userId` = "tst1brydfvew", `permlink` = "dzhordzh-karlin", `refBlockNum` = 17004 from response.item.contentId
        // 3. run current API
        RestAPIManager.instance.loadPost(userID:        "d5gqchmbgrdj",
                                         permlink:      "athenafightswithiphigeniaagainstdione",
                                         completion:    { (post, errorAPI) in
                                            guard errorAPI == nil else {
                                                Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
                                                return
                                            }
                                            
                                            Logger.log(message: "Response: \n\t\(post!)", event: .debug)
        })
    }
    

    /// Test API `content.getProfile`
    func testGetProfile() {
//        let result = self.deleteAllKeys()
        
        RestAPIManager.instance.getProfile(userID:          Config.currentUser.id ?? "XXX",
                                           completion:      { (userProfile, errorAPI) in
                                            guard errorAPI == nil else {
                                                Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
                                                return
                                            }
                                            
                                            Logger.log(message: "userProfile: \n\t\(userProfile!)", event: .debug)
        })
    }

    
    /// Test API `content.getComments` by user
    //  1. run API 'content.getPost`
    //  2. get `userId`, `permlink`, `refBlockNum` from response.item.contentId
    //  3. run current API
    func testGetUserCommentsByUser() {
        RestAPIManager.instance.loadUserComments(nickName:      "d5gqchmbgrdj",
                                                 completion:    { (comments, errorAPI) in
                                                    guard errorAPI == nil else {
                                                        Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
                                                        return
                                                    }
                                                    
                                                    Logger.log(message: "Response: \n\t\(comments!)", event: .debug)
        })
    }
    
    
    /// Test API `content.getComments` by post
    //  1. run `FacadeService().testGetFeed()`
    func testGetUserCommentsByPost() {
        let paginationSequenceKey: String? = nil
        
        RestAPIManager.instance.loadPostComments(nickName:                  "d5gqchmbgrdj",
                                                 permlink:                  "athenafightswithiphigeniaagainstdione",
                                                 paginationSequenceKey:     paginationSequenceKey,
                                                 completion:                { (comments, errorAPI) in
                                                    guard errorAPI == nil else {
                                                        Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
                                                        return
                                                    }
                                                    
                                                    Logger.log(message: "Response: \n\t\(comments!)", event: .debug)
        })
    }
    
    
    /// Test API `push.historyFresh`
    func testGetPushHistoryFresh() {
        RestAPIManager.instance.getPushHistoryFresh(completion: { (history, errorAPI) in
            guard errorAPI == nil else {
                Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
                return
            }
            
            Logger.log(message: "history: \n\t\(history!)", event: .debug)
        })
    }

    
    /// Test API `options.get`
    func testGetOptions() {
        RestAPIManager.instance.getOptions(responseHandling: { (response) in
            Logger.log(message: "response: \n\t\(response)", event: .debug)
        },
                                           errorHandling: { (errorAPI) in
                                            Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
        })
    }

    
    /// Test API basic `options.set`
    func testSetBasicOptions() {
        RestAPIManager.instance.setBasicOptions(language:           "ua",
                                                nsfwContent:        .alwaysAlert,
                                                responseHandling:   { (response) in
                                                    Logger.log(message: "response: \n\t\(response)", event: .debug)
                                                    self.testGetOptions()
        },
                                                errorHandling:      { (errorAPI) in
                                                    Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
        })
    }
    

    /// Test API push/notify `options.set`
    func testSetOptions() {
        let noticeOptions = RequestParameterAPI.NoticeOptions(vote:                 true,
                                                              flag:                 true,
                                                              transfer:             true,
                                                              reply:                true,
                                                              subscribe:            true,
                                                              unsubscribe:          true,
                                                              mention:              false,
                                                              repost:               false,
                                                              reward:               true,
                                                              curatorReward:        true,
                                                              message:              true,
                                                              witnessVote:          true,
                                                              witnessCancelVote:    false)
        
        RestAPIManager.instance.set(options:            noticeOptions,
                                    type:               .notify,
                                    responseHandling:   { (response) in
                                        Logger.log(message: "response: \n\t\(response)", event: .debug)
                                        self.testGetOptions()
        },
                                    errorHandling:      { (errorAPI) in
                                        Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
        })
    }
    
    
    /// Test API `onlineNotify.historyFresh`
    func testGetOnlineNotifyHistoryFresh() {
        RestAPIManager.instance.getOnlineNotifyHistoryFresh(completion: { (response, errorAPI) in
            guard errorAPI == nil else {
                Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
                return
            }

            Logger.log(message: "response: \n\t\(response!)", event: .debug)
        })
    }
    
    
    /// Test API `notify.markAsRead`
    func testMarkNotifiesAsRead() {

    }

    
    /// Test API `meta.recordPostView`
    //  1. get feed list
    //  2. select any post
    //  3. get author permlink value
    func testRecordPostView(authorPermlink: String) {
        RestAPIManager.instance.recordPostView(permlink:            authorPermlink,
                                               responseHandling:    { response in
                                                Logger.log(message: "response: \n\t\(response)", event: .debug)
        },
                                               errorHandling:       { errorAPI in
                                                Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
        })
    }
    
    
    /// Test API `favorites.get`
    //  1. user only for current auth user
    func testGetFavorites() {
        if Config.currentUser.id != nil {
            RestAPIManager.instance.getFavorites(responseHandling:  { response in
                                                    Logger.log(message: "response: \n\t\(response)", event: .debug)
            },
                                                 errorHandling:     { errorAPI in
                                                    Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
            })
        }
    }

    
    /// Test API `favorites.add`
    //  1. user only for current auth user
    func testAddFavorites() {
        if Config.currentUser.id != nil {
            RestAPIManager.instance.addFavorites(permlink:          "oesowgfuzfif/kjbkbjbbjk",
                                                 responseHandling:  { response in
                                                    Logger.log(message: "response: \n\t\(response)", event: .debug)
            },
                                                 errorHandling:     { errorAPI in
                                                    Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
            })
        }
    }


    /// Test API `favorites.remove`
    //  1. user only for current auth user
    func testRemoveFavorites() {
        if Config.currentUser.id != nil {
            RestAPIManager.instance.removeFavorites(permlink:           "oesowgfuzfif/kjbkbjbbjk",
                                                    responseHandling:   { response in
                                                        Logger.log(message: "response: \n\t\(response)", event: .debug)
            },
                                                    errorHandling:      { errorAPI in
                                                        Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
            })
        }
    }
    
    
    /// Test API `push.notifyOff`
    //  1. user only for current auth user
    func testPushNotifyOff() {
//        if Config.currentUser.id != nil {
//            RestAPIManager.instance.pushNotifyOff(fcmToken:             "f-6-jlxtS24:APA91bG0LhMV99uMjZSmOikvPg0EW8Yl4ryQ7Q5GEtC_QWtdhuTIUaqx6LGAfjyfNeFJcc1u2Hi20-eg-FihgKpJVvOQJLzIQvHIhR1ldVzYdLBbMl9MXRAx13DQPSKq6U-aPQEIBz6h",
//                                                    responseHandling:   { response in
//                                                        Logger.log(message: "response: \n\t\(response)", event: .debug)
//            },
//                                                    errorHandling:      { errorAPI in
//                                                        Logger.log(message: errorAPI.caseInfo.message.localized(), event: .error)
//            })
//        }
    }
}
