//
//  ChangePassVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 26/11/2022.
//

import UIKit
import SwiftyJSON

class ChangePassVC: BaseVC {

    @IBOutlet weak var oldPassTxt: UITextField!
    @IBOutlet weak var newPassTxt: UITextField!
    @IBOutlet weak var confPassTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Change password"
    }
    
    @IBAction func updateTap(_ sender: Any) {
        self.resignAll()
        let oldpassValid = Validator.validateString(text: oldPassTxt.text, type: "Old Password")
        if !oldpassValid.0 {
            print(oldpassValid.1)
            self.showTool(msg: oldpassValid.1, state: .error)
            return
        }
        let passValid = Validator.validatePassword(text: newPassTxt.text)
        if !passValid.0 {
            print(passValid.1)
            self.showTool(msg: passValid.1, state: .error)
            return
        }
        
        if newPassTxt.text != confPassTxt.text {
            self.showTool(msg: "Password doesn't match", state: .error)
            return
        }
             
        
        var dic = Dictionary<String, AnyObject>()
        dic["old_password"] = oldPassTxt.text as AnyObject
        dic["new_password"] = newPassTxt.text as AnyObject
        dic["new_password_confirmation"] = newPassTxt.text as AnyObject
       
        print(dic)
        Util.shared.showSpinner()
        ALF.shared.doPostData(parameters: dic, method: "auth/update_old_password") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        self.showTool(msg: json["message"].string ?? "Password Changed Successfully", state: .success)
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
