//
//  SupoortVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 26/11/2022.
//

import UIKit
import SwiftyJSON

class SupoortVC: BaseVC {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var subTxt: UITextField!
    @IBOutlet weak var msgTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Support"
        
        emailTxt.text = Util.getUser()?.email ?? ""
    }
    

    @IBAction func sendTap(_ sender: Any) {
        self.resignAll()
        let emailValid = Validator.validateEmail(text: emailTxt.text)
        if !emailValid.0 {
            print(emailValid.1)
            self.showTool(msg: emailValid.1, state: .error)
            return
        }
        let subTxtValid = Validator.validateString(text: subTxt.text, type: "Subject")
        if !subTxtValid.0 {
            print(subTxtValid.1)
            self.showTool(msg: subTxtValid.1, state: .error)
            return
        }
        let msgValid = Validator.validateString(text: subTxt.text, type: "Message")
        if !msgValid.0 {
            print(msgValid.1)
            self.showTool(msg: msgValid.1, state: .error)
            return
        }
             
        
        var dic = Dictionary<String, AnyObject>()
        dic["email"] = emailTxt.text as AnyObject
        dic["subject"] = subTxt.text as AnyObject
        dic["message"] = msgTxt.text as AnyObject
       
        print(dic)
        Util.shared.showSpinner()
        ALF.shared.doPostData(parameters: dic, method: "help/contact") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        self.showTool(msg: json["message"].string ?? "Message Sent Successfully", state: .success)
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
