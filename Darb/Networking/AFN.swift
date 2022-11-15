
//  WebService.swift
//  BrandsPK

//  Created by musharraf on 12/1/16.
//  Copyright © 2016 Stars Developer. All rights reserved.


import UIKit
import AFNetworking


//typealias SuccessBlock = (_ response: AnyObject) -> Void
//typealias FailureBlock = (_ response: AnyObject) -> Void

class AFN: NSObject {

    
    static let shared = AFN()

//    private override init() {
//
//    }
   
    private func urlString(subUrl: String) -> String {
        
        return "https://project.cyphersol.com/emj/emjApi/\(subUrl)"
        
       
    }

    func doGetData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {

        self.getMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }

    func doPostData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {

        self.postMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    func doPostDataWithImage(parameters: Dictionary<String, AnyObject>, method: String, image: UIImage?, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {

        self.postMethodWithParamsAndImage(parameters: parameters, forMethod: self.urlString(subUrl: method), image: image, success: success, fail: fail)
    }
    
    private func postMethodWithParamsAndImage(parameters: Dictionary <String, AnyObject>, forMethod: String, image: UIImage?, success:@escaping SuccessBlock, fail:@escaping FailureBlock){

        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")

        var headers = [String: String]()
//        if Util.isLoggedIn(){
//            manager.requestSerializer.setValue(Util.getUser()!.token, forHTTPHeaderField: "Authorization")
//            headers["Authorization"] = "Util.getUser()!.token"
//        }

        manager.post(forMethod, parameters: parameters, headers: headers) { progress in
            
        } success: { task, formData in
            if image != nil
            {
                var imgData = (image?.jpeg(.lowest))!
                
                print(imgData.count)
                
                (formData as AnyObject).appendPart(withForm: "image".data(using: String.Encoding.utf8, allowLossyConversion: true)!, name: "image.jpg")
            }
            success(formData as AnyObject)
        } failure: { task, error in
            fail(error as AnyObject)
        }
    }
    
    private func postMethodWithParams(parameters: Dictionary <String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
//
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        var headers = [String: String]()
//        if Util.isLoggedIn(){
//            manager.requestSerializer.setValue(Util.getUser()!.token, forHTTPHeaderField: "Authorization")
//            headers["Authorization"] = "Util.getUser()!.token"
//        }
        
        manager.post(forMethod, parameters: parameters, headers: headers) { progress in
            
        } success: { task, formData in
            success(formData as AnyObject)
        } failure: { task, error in
            fail(error as AnyObject)
        }

        
    }

    private func getMethodWithParams(parameters: Dictionary<String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){

        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        var headers = [String: String]()
//        if Util.isLoggedIn(){
//            manager.requestSerializer.setValue(Util.getUser()!.token, forHTTPHeaderField: "Authorization")
//            headers["Authorization"] = "Util.getUser()!.token"
//        }
        
        manager.get(forMethod, parameters: parameters, headers: headers) { progress in
            
        } success: { task, formData in
            success(formData as AnyObject)
        } failure: { task, error in
            fail(error as AnyObject)
        }
    }
}
