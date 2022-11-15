//
//  Validator.swift
//  EyecareBrands
//
//  Created by Naveed ur Rehman on 26/08/2022.
//

import UIKit

class Validator: NSObject {

    static let shared = Validator()

    class func validateEmail(text: String?) -> (Bool, String){
        if text == nil || text?.count == 0 {
            return (false, "Email is required.")
        }
        if !self.isValidEmail(text: text!) {
            return (false, "Email is not vaild.")
        }
        return (true, "Email is vaild.")
    }
    
    class private func isValidEmail(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: text)
    }
    
    class func validatePassword(text: String?) -> (Bool, String){
        if text == nil || text?.count == 0 {
            return (false, "Password is required.")
        }
        if text!.count < 6 {
            return (false, "Password should be of at least 6 in length.")
        }
        
        return (true, "Password is vaild.")
    }
    
    class func validatePhone(text: String?, type: String) -> (Bool, String){
        if text == nil || text?.count == 0 {
            return (false, "\(type) is required.")
        }
        if text!.count < 10 {
            return (false, "\(type) is not valid.")
        }
        
        return (true, "\(type) is vaild.")
    }
    
    class func validateString(text: String?, type: String) -> (Bool, String){
        if text == nil || text?.count == 0 {
            return (false, "\(type) is required.")
        }
        return (true, "\(type) is valid.")
    }
}

