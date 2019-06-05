import Foundation

public struct TransactionAbi : Encodable {
    // Old `transaction_header`: https://github.com/GolosChain/cyberway.contracts/blob/d7a68c2f0e97d8999f0006cbc72c5dd465d1061a/cyber.msig/abi/cyber.msig.abi#L244-L273
    public let expiration: TimestampWriterValue
    public let ref_block_num: BlockNumWriterValue
    public let ref_block_prefix: BlockPrefixWriterValue
    public let max_net_usage_words: UInt32
    public let max_cpu_usage_ms: UInt8
    // New `transaction_header`: https://github.com/GolosChain/cyberway.contracts/blob/master/cyber.msig/abi/cyber.msig.abi#L244-L281
    public let max_ram_kbytes: UInt32
    public let max_storage_kbytes: UInt32
    public let delay_sec: UInt32
    public let context_free_actions: [ActionAbi]
    public let actions: [ActionAbi]
    public let transaction_extensions: StringCollectionWriterValue

    
    public init(expiration: TimestampWriterValue, ref_block_num: BlockNumWriterValue, ref_block_prefix: BlockPrefixWriterValue, max_net_usage_words: UInt32, max_cpu_usage_ms: UInt8, max_ram_kbytes: UInt32, max_storage_kbytes: UInt32, delay_sec: UInt32, context_free_actions: [ActionAbi], actions: [ActionAbi], transaction_extensions: StringCollectionWriterValue) {
        self.expiration                 =   expiration
        self.ref_block_num              =   ref_block_num
        self.ref_block_prefix           =   ref_block_prefix
        self.max_net_usage_words        =   max_net_usage_words
        self.max_cpu_usage_ms           =   max_cpu_usage_ms
        self.max_ram_kbytes             =   max_ram_kbytes
        self.max_storage_kbytes         =   max_storage_kbytes
        self.delay_sec                  =   delay_sec
        self.context_free_actions       =   context_free_actions
        self.actions                    =   actions
        self.transaction_extensions     =   transaction_extensions

    }
    
    
    func convertToJSON() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        return jsonString
    }
}
