//
//  ViewController.swift
//  TestMyLib
//
//  Created by msm72 on 3/18/19.
//  Copyright © 2019 golos.io. All rights reserved.
//

import UIKit
import CyberSwift

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var testFlagImageView: UIImageView! {
        didSet {
            testFlagImageView.layer.cornerRadius = testFlagImageView.frame.height / 2
            testFlagImageView.clipsToBounds = true
        }
    }
    
    
    // MARK: - Class Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let list = PhoneCode.getCountries()
//
//        let data = try? Data(contentsOf: list[2].flagURL)
//        self.testFlagImageView.image = UIImage(data: data!)
    }
    
    
    // MARK: - Actions
    @IBAction func testAuthButtonTapped(_ sender: UIButton) {
        /// API `auth.authorize`
        //  1. run after get `sign` websocket secret key
        FacadeService().testAuthorize()
    }
    
    @IBAction func testButtonTapped(_ sender: UIButton) {
//        self.messageVote()
//        EOSService().testPostingImage()
        

        // FACADE-SERVICE
        /// Test API `content.getFeed`
//        FacadeService().testGetFeed()

        
        /// Test API `content.getProfile`
//        FacadeService().testGetProfile(nickName: Config.testUserAccount.nickName)
        
        
//        FacadeService().testGetUserCommentsByUser()
//        FacadeService().testGetUserCommentsByPost()
        
        /// Options
//        FacadeService().testGetOptions()
//        FacadeService().testSetBasicOptions()
//        FacadeService().testSetPushOptions()
        
//        FacadeService().testGetPost()
//        FacadeService().testGetOnlineNotifyHistoryFresh()
        
        /// Test API `meta.recordPostView`
//        FacadeService().testRecordPostView(authorPermlink: "")
        
        
        // EOS
        /// Contract `gls.publish` action `createmssg`
//        EOSService().testCreatePostMessage()

        
        /// Contract `gls.publish` action `updatemssg`
        EOSService().testUpdatePostMessage()

        
//        self.messageVote()

        
//        EOSService().testReblog(messageAuthor:          "tst2jejxypdx",
//                                messagePermlink:        "title2-2019-04-26t07-43-58",
//                                messageRefBlockNum:     198452,
//                                messageRebloger:        "tst2jejxypdx")
//
//        EOSService().testRegwitness()
//        EOSService().testVotewitness()
//        EOSService().testUnvotewitness()
//        EOSService().testUnregwitness()
        
        // First, run `FacadeService().testGetFeed()`
//        EOSService().testReblog()
        
        
        // REGISTRATION-SERVICE
//        RegistrationService().testGetState(phone: "+79602806441")
//        RegistrationService().testFirstStep(phone: "+79602806441")
//        RegistrationService().resendSmsCode(phone: "+79602806440")
//        RegistrationService().testVerify(phone: "+79602806440", code: "6974")
        
        
        
//        FacadeService().testGetPushHistoryFresh()
    }
}


// MARK: - TEST FUNC
extension ViewController {
    func deleteAllKeys() -> Bool {
        guard   KeychainManager.deleteData(forUserNickName: Config.currentUserNickNameKey, withKey: Config.currentUserNickNameKey),
                KeychainManager.deleteData(forUserNickName: Config.currentUserPublicActiveKey, withKey: Config.currentUserPublicActiveKey) else { return false }
        
        return true
    }
    
    
//    func testGenerateSecret() {
//        RestAPIManager.instance.generateSecret(completion: { (generatedSecret, errorAPI) in
//            guard errorAPI == nil else {
//                Logger.log(message: errorAPI!.caseInfo.message.localized(), event: .error)
//                return
//            }
//            
//            Logger.log(message: generatedSecret!.secret, event: .debug)
//        })
//    }
    
    
    
    
    
    /// EOS: contract `gls.publish`, actions `upvote`, `downvote`, `unvote`
    func messageVote() {
        // First run 'testAuthorize()'
        // Second run 'getFeed()'
        let voteType: VoteType          =   .upvote
        let messagePermlink: String     =   "title2-2019-05-20t10-35-36"
        let messageAuthor: String       =   "tst2jejxypdx"
        let refBlockNum: UInt64         =   893085
        
//        Config.isPublicTestnet = true
        
        RestAPIManager.instance.message(voteType:        voteType,
                                        author:          messageAuthor,
                                        permlink:        messagePermlink,
                                        weight:          voteType == .unvote ? 0 : 10_000,
                                        refBlockNum:     refBlockNum,
                                        completion:      { (response, error) in
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
