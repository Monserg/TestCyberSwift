//
//  RequestParameterAPI.swift
//  GoloSwift
//
//  Created by msm72 on 01.06.2018.
//  Copyright © 2018 golos. All rights reserved.
//

import UIKit

protocol RequestParameterAPIOperationPropertiesSupport {
    var code: Int? { get set }
    var name: String? { get set }
    func getProperties() -> [String: Any]
    func getPropertiesNames() -> [String]
}

public enum NsfwContentMode: String {
    case alwaysAlert    =   "Always alert"
}

public struct RequestParameterAPI {
    static func decodeToString(model: RequestParameterAPIOperationPropertiesSupport) -> String? {
        // Data encoder
        let jsonEncoder = JSONEncoder()
        var jsonData = Data()
        
        // Add operation name
        var result = String(format: "\"%@\",{", model.name ?? "")
        Logger.log(message: "\nResult + operationName:\n\t\(result)", event: .debug)
        
        let properties = model.getProperties()
        let propertiesNames = model.getPropertiesNames()
        
        do {
            for (_, propertyName) in propertiesNames.enumerated() {
                let propertyValue = properties.first(where: { $0.key == propertyName })!.value
                
                // Casting Types
                if propertyValue is String {
                    jsonData = try jsonEncoder.encode(["\(propertyName)": "\(propertyValue)"])
                }
                    
                else if propertyValue is Int64 {
                    jsonData = try jsonEncoder.encode(["\(propertyName)": propertyValue as! Int64])
                }
                    
                else if let data = try? JSONSerialization.data(withJSONObject: propertyValue, options: []) {
                    jsonData = data
                    result += "\"\(propertyName)\":" + "\(String(data: jsonData, encoding: .utf8)!),"
                    continue
                }
                
                result += "\(String(data: jsonData, encoding: .utf8)!)"
                Logger.log(message: "\nResult + \"\(propertyName)\":\n\t\(result)", event: .debug)
            }
            
            return  result
                .replacingOccurrences(of: "{{", with: "{")
                .replacingOccurrences(of: "}{", with: ",")
                .replacingOccurrences(of: "],{", with: "],")
                .replacingOccurrences(of: "}\"}", with: "}\"")
        } catch {
            Logger.log(message: "Error: \(error.localizedDescription)", event: .error)
            return nil
        }
    }
    
    
    // MARK: -
    public struct BasicOptions: Encodable {
        // MARK: - Properties
        public let language: String
        public let nsfwContent: String
        
        
        // MARK: - Initialization
        public init(language: String = "ru", nsfwContent: String = NsfwContentMode.alwaysAlert.rawValue) {
            self.language           =   language
            self.nsfwContent        =   nsfwContent
        }
        
        
        // MARK: - Functions
        // Template: "language": <languageValue>, "nsfwContent": <nsfwContentValue>
        public func getBasicOptionsValues() -> String {
            return  String(format: "\"language\": %@, \"nsfwContent\": %@", self.language, self.nsfwContent)
        }
    }
        

    // MARK: -
    public struct NoticeOptions: Encodable {
        // MARK: - Properties
        public let vote: Bool
        public let flag: Bool
        public let transfer: Bool
        public let reply: Bool
        public let subscribe: Bool
        public let unsubscribe: Bool
        public let mention: Bool
        public let repost: Bool
        public let reward: Bool
        public let curatorReward: Bool
        public let message: Bool
        public let witnessVote: Bool
        public let witnessCancelVote: Bool
        
        
        // MARK: - Initialization
        public init(vote: Bool = true, flag: Bool = true, transfer: Bool = true, reply: Bool = true, subscribe: Bool = true, unsubscribe: Bool = true, mention: Bool = true, repost: Bool = true, reward: Bool = true, curatorReward: Bool = true, message: Bool = true, witnessVote: Bool = true, witnessCancelVote: Bool = true) {
            self.vote               =   vote
            self.flag               =   flag
            self.transfer           =   transfer
            self.reply              =   reply
            self.subscribe          =   subscribe
            self.unsubscribe        =   unsubscribe
            self.mention            =   mention
            self.repost             =   repost
            self.reward             =   reward
            self.curatorReward      =   curatorReward
            self.message            =   message
            self.witnessVote        =   witnessVote
            self.witnessCancelVote  =   witnessCancelVote
        }
        
        // MARK: - Functions
        // Template: "upvote": <upvote>, "downvote": <downvote>, "reply": <reply>, "transfer": <transfer>, "subscribe": <subscribe>, "unsubscribe": <unsibscribe>, "mention": <mention>, "repost": <repost>,  "message": <message>, "witnessVote": <witnessVote>, "witnessCancelVote": <witnessCancelVote>, "reward": <reward>, "curatorReward": <curatorReward>
        public func getNoticeOptionsValues() -> String {
            return  String(format: "\"vote\": %d, \"flag\": %d, \"reply\": %d, \"transfer\": %d, \"subscribe\": %d, \"unsubscribe\": %d, \"mention\": %d, \"repost\": %d, \"message\": %d, \"witnessVote\": %d, \"witnessCancelVote\": %d, \"reward\": %d, \"curatorReward\": %d", self.vote.intValue, self.flag.intValue, self.reply.intValue, self.transfer.intValue, self.subscribe.intValue, self.unsubscribe.intValue, self.mention.intValue, self.repost.intValue, self.message.intValue, self.witnessVote.intValue, self.witnessCancelVote.intValue, self.reward.intValue, self.curatorReward.intValue)
        }
    }
}
