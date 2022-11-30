//
//  ChatModel.swift
//  Darb
//
//  Created by Naveed ur Rehman on 29/11/2022.
//

import UIKit

class ChatModel: NSObject, NSCoding{
    
    var message : String!
    var time : String!
    var type : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String
        time = dictionary["time"] as? String
        type = dictionary["type"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if message != nil{
            dictionary["message"] = message
        }
        if time != nil{
            dictionary["time"] = time
        }
        if type != nil{
            dictionary["type"] = type
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         message = aDecoder.decodeObject(forKey: "message") as? String
         time = aDecoder.decodeObject(forKey: "time") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if time != nil{
            aCoder.encode(time, forKey: "time")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }

    }

}
