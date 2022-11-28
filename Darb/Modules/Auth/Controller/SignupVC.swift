//
//  SignupVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 17/11/2022.
//

import UIKit
import SwiftyJSON
import StyledString

class SignupVC: BaseVC {

    @IBOutlet weak var fNameTxt: UITextField!
    @IBOutlet weak var lNameTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var chkImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var termsBtn: UIButton!
    
    var isTemchk = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backBtn.setTitle("", for: .normal)
        let forgotPassTitle = StyledString("terms & conditions.").with(foregroundColor: UIColor(hexString: "#386AFF")).with(font: UIFont(name: AppFonts.roboto, size: 12)).with(underlineStyle: .single, color: UIColor(hexString: "#386AFF"))
        termsBtn.setAttributedTitle(forgotPassTitle.nsAttributedString, for: .normal)
    }
    
    @IBAction func backTap(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func termChkTap(_ sender: Any) {
        self.resignAll()
        if isTemchk {
            chkImg.image = UIImage(named: "ic_checked")
        } else {
            chkImg.image = UIImage(named: "ic_checked_checkbox")
        }
        isTemchk = !isTemchk
    }
    
    @IBAction func termsTap(_ sender: Any) {
        self.resignAll()
        //        "https://www.eyecarebrands.com/login".aa_openURL()
    }
    
    @IBAction func continueTap(_ sender: Any) {
        self.resignAll()
        let emailValid = Validator.validateEmail(text: emailTxt.text)
        if !emailValid.0 {
            print(emailValid.1)
            self.showTool(msg: emailValid.1, state: .error)
            return
        }
        
        let fNameValid = Validator.validateString(text: fNameTxt.text, type: "First name")
        if !fNameValid.0 {
            print(fNameValid.1)
            self.showTool(msg: fNameValid.1, state: .error)
            return
        }
        
        let lNameValid = Validator.validateString(text: fNameTxt.text, type: "Last name")
        if !lNameValid.0 {
            print(lNameValid.1)
            self.showTool(msg: lNameValid.1, state: .error)
            return
        }
        
        let phoneValid = Validator.validatePhone(text: phoneTxt.text, type: "Phone")
        if !phoneValid.0 {
            print(phoneValid.1)
            self.showTool(msg: phoneValid.1, state: .error)
            return
        }
        
        let passValid = Validator.validatePassword(text: passTxt.text)
        if !passValid.0 {
            print(passValid.1)
            self.showTool(msg: passValid.1, state: .error)
            return
        }
        
        var dic = Dictionary<String, AnyObject>()
        dic["first_name"] = fNameTxt.text as AnyObject
        dic["last_name"] = lNameTxt.text as AnyObject
        dic["email"] = emailTxt.text as AnyObject
        dic["password"] = passTxt.text as AnyObject
        dic["phone_no"] = phoneTxt.text as AnyObject
        
        print(dic)
        Util.shared.showSpinner()
        ALF.shared.doPostData(parameters: dic, method: "auth/register") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status"].int {
                    if statusRange.contains(status) {
                        
                        if let user = json["data"].dictionaryObject {
                            if let usrStr = user.aa_json {
                                UserDefaults.standard.set(usrStr, forKey: "user")    
                                SceneDelegate.shared?.checkUserLoggedIn()
                            }
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
