//
//  ViewController.swift
//  TestMyLib
//
//  Created by msm72 on 3/18/19.
//  Copyright © 2019 golos.io. All rights reserved.
//

import UIKit
import CyberSwift
import PDFReader

class ViewController: UIViewController {
    // MARK: - Properties
    var pdfViewController: PDFViewController?
    
    
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
//        FacadeService().testGetProfile()
        
        
        /// Test action `reblog`
//        EOSService().testMessageReblog(author:      "tst2dqowtufr",
//                                       permlink:    "hestiafightswithandromacheagainstperses",
//                                       rebloger:    Config.currentUser.nickName ?? "",
//                                       title:       "Reblog title 1",
//                                       body:        "Reblog body 1")
        
        
        /// Test API `favorites.get`
//        FacadeService().testGetFavorites()

        
        /// Test API `favorites.add`
//        FacadeService().testAddFavorites()

        
        /// Test API `favorites.remove`
//        FacadeService().testRemoveFavorites()

        
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
        /// Contract `gls.social` action `updatemeta`
//        EOSService().testUpdatemeta()


        /// Contract `gls.publish` action `createmssg`
        EOSService().testCreatePostMessage()
//        EOSService().testCreateCommentMessage(parentPermlink: "title2-2019-06-07t04-49-04", tags: ["#jfks", "#sfndkl"])
        
        /// Contract `gls.publish` action `updatemssg`
//        EOSService().testUpdatePostMessage()

        
        /// Contract `gls.publish` action `deletemssg`
//        EOSService().testDeletePostMessage()

        
        /// Contract `gls.publish` action `upvote`
//        EOSService().testMessage(voteActionType: .downvote, author: "", permlink: "")
        
        
        
//        EOSService().testReblog(messageAuthor:          "tst2jejxypdx",
//                                messagePermlink:        "title2-2019-04-26t07-43-58",
//                                messageRefBlockNum:     198452,
//                                messageRebloger:        "tst2jejxypdx")
//
        
        
        /// Contract `gls.ctrl`, action `regwitness` (1)
//        EOSService().testRegwitness()


        /// Contract `gls.ctrl`, action `votewitness` (2)
//        EOSService().testVotewitness()
        
        
        /// Contract `gls.ctrl`, action `unvotewitn` (3)
//        EOSService().testUnvotewitness()
        
        
        /// Contract `gls.ctrl`, action `unregwitness` (4)
//        EOSService().testUnregwitness()
        
        
        // First, run `FacadeService().testGetFeed()`
//        EOSService().testReblog()
        
        
        // REGISTRATION-SERVICE
//        RegistrationService().testGetState(phone: "+79602806441")
//        RegistrationService().testFirstStep(phone: "+79602806441")
//        RegistrationService().resendSmsCode(phone: "+79602806443")
//        RegistrationService().testVerify(phone: "+79602806443", code: "9999")
//        RegistrationService().testSetUser(id: "testuserr1", phone: "+79602806441")
        
        
//        FacadeService().testGetPushHistoryFresh()
        
        
        // Create PDF file
//        KeychainManager.createPDFFile(id: "1111", name: "XXX", memo: "SDFFs", owner: "SDFBDBDBDBSS", active: "sdfldflf", posting: "xcnvm,n skdjf ksjdkf jsdkljfklds")
//
//        // Preview PDF file
//        if let pdfDocument = KeychainManager.loadPDFDocument() {
//            self.displayPDF(document: pdfDocument)
//        }
        
        
//        FacadeService().testPushNotifyOff()
    }
}


// MARK: - TEST FUNC
extension ViewController {
    func displayPDF(document: PDFDocument) {
        let closeButton = UIBarButtonItem(title: "Close".localized(), style: .done, target: self, action:  #selector(myCancelFunc(sender:)))
        /// Provide your button to createNew using the backButton parameter.  The PDFViewController will then use your button instead of the default backbutton.
        self.pdfViewController = PDFViewController.createNew(with: document, title: "User keys info", actionStyle: .activitySheet, backButton: closeButton)
        self.pdfViewController?.backgroundColor = .white
        self.navigationController?.pushViewController(self.pdfViewController ?? UIViewController(), animated: true)
    }
    
    @objc func myCancelFunc(sender: UIBarButtonItem) {
        self.deletePDF()
        self.pdfViewController?.navigationController?.popViewController(animated: true)
    }
    
    func deletePDF() {
        let documentsDirectory  =   NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath            =   (documentsDirectory as NSString).appendingPathComponent("userKeys.pdf") as String

        do {
            try FileManager.default.removeItem(atPath: filePath)
            
            if let pdfDocument = KeychainManager.loadPDFDocument() {
                Logger.log(message: pdfDocument.fileName, event: .debug)
            } else {
                Logger.log(message: "PDF-file deleted!!!", event: .severe)
            }
        } catch {
            Logger.log(message: error.localizedDescription, event: .error)
        }
        
    }
    
    func deleteAllKeys() -> Bool {
        guard   KeychainManager.deleteData(forUserNickName: Config.currentUserNameKey, withKey: Config.currentUserNameKey),
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
}
