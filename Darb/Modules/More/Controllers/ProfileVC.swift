//
//  ProfileVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 25/11/2022.
//

import UIKit
import SwiftyJSON

class ProfileVC: BaseVC, UITextFieldDelegate {
    
    @IBOutlet weak var nameLbls: UILabel!
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Profile"
        setData()
    }
    
    func setData() {
        if let usr = Util.getUser() {
            let name = "\(usr.firstName ?? "")\(usr.lastName ?? "")"
            nameLbls.text = name.getAcronyms().uppercased()
            fName.text = usr.firstName ?? ""
            lName.text = usr.lastName ?? ""
            email.text = usr.email ?? ""
            phone.text = usr.phoneNo ?? ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == fName || textField == lName {
            let name = "\(fName.text ?? "")\(lName.text ?? "")"
            nameLbls.text = name.getAcronyms().uppercased()
        }
    }
    
    @IBAction func updateTap(_ sender: Any) {
        self.resignAll()
        self.resignAll()
        
        let fNameValid = Validator.validateString(text: fName.text, type: "First name")
        if !fNameValid.0 {
            print(fNameValid.1)
            self.showTool(msg: fNameValid.1, state: .error)
            return
        }
        let lNameValid = Validator.validateString(text: lName.text, type: "Last name")
        if !lNameValid.0 {
            print(lNameValid.1)
            self.showTool(msg: lNameValid.1, state: .error)
            return
        }
        
        let phoneValid = Validator.validatePhone(text: phone.text, type: "Phone")
        if !phoneValid.0 {
            print(phoneValid.1)
            self.showTool(msg: phoneValid.1, state: .error)
            return
        }
             
        
        var dic = Dictionary<String, AnyObject>()
        dic["first_name"] = fName.text as AnyObject
        dic["last_name"] = lName.text as AnyObject
        dic["phone_no"] = phone.text as AnyObject
       
        print(dic)
        Util.shared.showSpinner()
        ALF.shared.doPostData(parameters: dic, method: "auth/update_profile") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if var user = json["data"].dictionaryObject {
                            let token = Util.getUser()!.apiToken
                            user["api_token"] = token
                            if let usrStr = user.aa_json {
                                UserDefaults.standard.set(usrStr, forKey: "user")
                            }
                        }
                        self.showTool(msg: json["message"].string ?? "Profile Updated Successfully", state: .success)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.goBackWithDelay()
                        }
                    } else {
                        self.showTool(msg: json["message"].string ?? "", state: .error)
                    }
                }
            }
            
        } fail: { response in
            Util.shared.hideSpinner()
            DispatchQueue.main.async {
                self.showTool(msg: response as? String ?? "Error", state: .error)
            }
        }
    }
    
    

}
