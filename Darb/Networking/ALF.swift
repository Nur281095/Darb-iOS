//
//  ALF.swift
//  EyecareBrands
//
//  Created by Naveed ur Rehman on 26/08/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias SuccessBlock = (_ response: AnyObject) -> Void
typealias FailureBlock = (_ response: AnyObject) -> Void

class ALF: NSObject {
    
    
    static let shared = ALF()
    

    private func urlString(subUrl: String) -> String {
    
        return "https://darb.nicelylogic.com/api/\(subUrl)"
        
    }
    
    /****************************  ***********************************/
    /******************* GET Method with PARAMS **********************/
    /****************************  ***********************************/
    
    func doGetData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.getMethodWithParams(parameters: parameters as Dictionary<String, AnyObject>, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func getMethodWithParams(parameters: Dictionary<String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        var headers: HTTPHeaders?
        if Util.isLoggedIn() {
            headers = ["Authorization": "Bearer \(Util.getUser()!.apiToken!)"]
        } else {
            headers = [:]
        }

        let manager = Alamofire.Session.default
        print(headers)
        manager.session.configuration.timeoutIntervalForRequest = 30
        print(parameters)
        manager.request(forMethod, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            print(parameters)
            switch response.result {
            case .success:
                if response.value != nil{
                    success(response.value as AnyObject)
                }
            case let .failure(error):
                print(error)
                fail(error as AnyObject)
            }
        }

    }
    
    
    /******************* END OF GET Method with PARAMS **********************/
    
    
    /****************************  ***********************************/
    /******************* POST Method with PARAMS *********************/
    /****************************  ***********************************/
    
    func doPostData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.postMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func postMethodWithParams(parameters: Dictionary<String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){

//        let session = URLSession.shared
//
//        //now create the URLRequest object using the url object
//        var request = URLRequest(url: URL(string: forMethod)!)
//        request.httpMethod = "POST" //set http method as POST
//        request.timeoutInterval = 30
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: []) // pass dictionary to nsdata object and set it as request body
//        } catch let error {
//            print(error.localizedDescription)
//        }
//
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////        if Util.isLoggedIn() {
////            request.addValue(Util.getUser()!.apiToken, forHTTPHeaderField: "Authorization")
////        }
//        //create dataTask using the session object to send data to the server
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
//
//            guard error == nil else {
//                fail(error!.localizedDescription as AnyObject)
//                return
//            }
//
//            guard let data = data else {
//                print(String(describing: error))
//                fail("Data not found" as AnyObject)
//
//                return
//            }
//
//              print(String(data: data, encoding: .utf8)!)
//            do {
//
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                    // handle json...
//                    let jsonObj = JSON(json)
//                    let status_code = jsonObj["status"].intValue
//                    let message = jsonObj["message"].stringValue
//                    if (200 ... 299).contains(status_code) {
//                        success(json as AnyObject)
//                    } else {
//                        fail(message as AnyObject)
//                    }
//                }
//            } catch let error {
//                fail(error.localizedDescription as AnyObject)
//            }
//
//        })
//        task.resume()
        
        var headers: HTTPHeaders?
        let manager = Alamofire.Session.default
        if Util.isLoggedIn() {
            headers = ["Authorization": "Bearer \(Util.getUser()!.apiToken!)"]
        } else {
            headers = [:]
        }
        print(headers)
        manager.session.configuration.timeoutIntervalForRequest = 30
        print(parameters)
        manager.request(forMethod, method: .post, parameters: parameters, headers: headers).responseJSON { response in
            print(parameters)
            switch response.result {
            case .success:
                if response.value != nil{
                    success(response.value as AnyObject)
                }
            case let .failure(error):
                print(error)
                fail(error as AnyObject)
            }
        }
        
    }
    /******************* END OF POST Method with PARAMS **********************/
    
    
    /****************************  ***********************************/
    /*************** POST Method with PARAMS and IMAGE *******************/
    /****************************  ***********************************/
    func doPostDataWithImage(parameters: [String:String], method: String, image: UIImage?, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        
        self.postMethodWithParamsAndImage(parameters: parameters, forMethod: self.urlString(subUrl: method), image: image, success: success, fail: fail)
    }
    
    
    private func postMethodWithParamsAndImage(parameters: [String:String], forMethod: String, image: UIImage?, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        let headers: HTTPHeaders?
        
        if Util.isLoggedIn() {
            headers = ["Authorization": "Bearer \(Util.getUser()!.apiToken!)"]
        } else {
            headers = [:]
        }
        manager.upload(
            multipartFormData: { multipartFormData in
                print(parameters)
                print(image as Any)
                if image != nil {
                    
                    var imgData = (image?.jpeg(.high))!
                    
                    print(imgData.count)
                    
                    multipartFormData.append(imgData, withName: "file", fileName: "image.png", mimeType: "image/png")
                    
                }
                if !(parameters.isEmpty) {
                    for (key, value) in parameters {
                        print("key: \(key) -> val: \(value)")
                        if let dic = value as? Dictionary<String,AnyObject>{
                            print(key)
                            print(value)
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
                                let str = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                                //                                multipartFormData.append(jsonData, withName: key)
                                multipartFormData.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                        }else{
                            multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                        }
                        
                    }
                }
                print(multipartFormData)
        },
            to: forMethod, method: .post , headers: headers)
            .response { response in
                switch response.result {
                case .success:
                    if response.value != nil{
                        success(response.value as AnyObject)
                    }
                case let .failure(error):
                    print(error)
                    fail(error as AnyObject)
                }
        }
    }
    func doPostDataWithMedia(parameters: [String:String], method: String, data: URL?,name: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        
        self.postMethodWithParamsAndMedia(parameters: parameters, forMethod: self.urlString(subUrl: method), filename: data, name: name, success: success, fail: fail)
    }
    
    private func postMethodWithParamsAndMedia(parameters: [String:String], forMethod: String, filename: URL?,name: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        let manager = Alamofire.Session.default
        
        let headers: HTTPHeaders?
        
        if Util.isLoggedIn() {
            headers = ["Authorization": "Bearer \(Util.getUser()!.apiToken!)"]
        } else {
            headers = [:]
        }
//
        manager.upload(
            multipartFormData: { multipartFormData in
                print(parameters)
                print(filename as Any)
                var data: Data?
                do {
                    data = try NSData(contentsOf: filename!, options: .uncached) as Data
                    print(data!)
                } catch {
                    
                }
                
                if data != nil {
                    multipartFormData.append(data!, withName: name)
                    //                    multipartFormData.append(filename!, withName: "filename")
                    
                }
                if !(parameters.isEmpty) {
                    for (key, value) in parameters {
                        print("key: \(key) -> val: \(value)")
                        if let dic = value as? Dictionary<String,AnyObject>{
                            print(key)
                            print(value)
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
                                let str = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                                //                                multipartFormData.append(jsonData, withName: key)
                                multipartFormData.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                        }else{
                            multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                        }
                        
                    }
                }
                print(multipartFormData)
        },
            to: forMethod, method: .post , headers: headers)
            .response { response in
                switch response.result {
                case .success:
                    if response.value != nil{
                        success(response.value as AnyObject)
                    }
                case let .failure(error):
                    print(error)
                    fail(error as AnyObject)
                }
        }
        
        
    }
    /******************* END OF POST Method with PARAMS and IMAGE **********************/
    
}
