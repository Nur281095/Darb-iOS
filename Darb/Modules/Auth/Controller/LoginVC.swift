//
//  LoginVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 17/11/2022.
//

import UIKit
import SwiftyJSON
import AAExtensions

class LoginVC: BaseVC {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var remebrBtn: UIButton!
    @IBOutlet weak var chkImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    var isRemeber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backBtn.setTitle("", for: .normal)
    }
    
    @IBAction func backTap(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func remeberChkTap(_ sender: Any) {
        self.resignAll()
        if isRemeber {
            chkImg.image = UIImage(named: "ic_checked")
        } else {
            chkImg.image = UIImage(named: "ic_checked_checkbox")
        }
        isRemeber = !isRemeber
    }
    
    @IBAction func forgotPassTap(_ sender: Any) {
        self.resignAll()
        let vc = UIStoryboard.storyBoard(withName: .auth).loadViewController(withIdentifier: .forgotPassVC)
        self.show(vc, sender: self)
    }
    
    @IBAction func continueTap(_ sender: Any) {
        self.resignAll()
        let emailValid = Validator.validateString(text: emailTxt.text, type: "Email")
        if !emailValid.0 {
            print(emailValid.1)
            self.showTool(msg: emailValid.1, state: .error)
            return
        }
        
        let passValid = Validator.validateString(text: passTxt.text, type: "Password")
        if !passValid.0 {
            print(passValid.1)
            self.showTool(msg: passValid.1, state: .error)
            return
        }
        
        var dic = Dictionary<String, AnyObject>()
        dic["email"] = emailTxt.text as AnyObject
        dic["password"] = passTxt.text as AnyObject
       
        print(dic)
        Util.shared.showSpinner()
        ALF.shared.doPostData(parameters: dic, method: "auth/login") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        
                        if let user = json["data"].dictionaryObject {
                            if let usrStr = user.aa_json {
                                DispatchQueue.main.async {
                                    UserDefaults.standard.set(usrStr, forKey: "user")
                                    SceneDelegate.shared?.checkUserLoggedIn()
                                }
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
