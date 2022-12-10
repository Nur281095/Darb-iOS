//
//  ChatVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 29/11/2022.
//

import UIKit
import GrowingTextView
import SwiftyJSON
import AAExtensions
import StyledString

class ChatVC: BaseVC {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputContainerViewBottom: NSLayoutConstraint!
    @IBOutlet weak var tblBot: NSLayoutConstraint!
    @IBOutlet weak var growingTextView: GrowingTextView!
   
    var chats = [ChatModel]()
    var schoolID = 0
    var otherName = ""
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = otherName
        
        handleGrowingTextView()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 65
        getChat()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    @objc func dismissKeyboard() {
        self.growingTextView.resignFirstResponder()
    }
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
            if keyboardHeight > 0 {
                keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom
            }
//            } else {
//                inputContainerViewBottom.constant = 0
//                scrollToBottom(height: 0)
//            }
            print(keyboardHeight)
            inputContainerViewBottom.constant = -keyboardHeight - 8
            scrollToBottom(height: keyboardHeight)
            view.layoutIfNeeded()
        }
    }
    func scrollToBottom(height: CGFloat){
        if self.chats.count > 0{
//            tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
//            tblView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            self.tblView.scrollToRow(at: IndexPath(row: self.chat.count - 1, section: 0), at: .bottom, animated: true)
            
            self.tblView.aa_scrollToBottom(true)
            self.view.layoutIfNeeded()
        }
        print("height: => \(height)")
    }
    
    func handleGrowingTextView(){
        self.growingTextView.font = UIFont(name: AppFonts.roboto_light, size: 16)
        self.growingTextView.maxHeight = 80
        self.growingTextView.autocorrectionType = .no
        self.growingTextView.spellCheckingType = .no
    }
    
    func getChat() {
        
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: [:], method: "school_chats?admin_id=\(schoolID)&page=1&limit=50") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.chats.append(ChatModel(fromDictionary: d))
                            }
                        }
                        self.tblView.reloadData()
                        self.scrollToBottom(height: 0)

                    } else {
                        self.showTool(msg: json["message"].string ?? "", state: .error)
                    }
                }
                if self.timer == nil {
                    self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.getSignleMsg), userInfo: nil, repeats: true)
                }
            }
            
        } fail: { response in
            Util.shared.hideSpinner()
            DispatchQueue.main.async {
                self.showTool(msg: response as? String ?? "Error", state: .error)
            }
        }
    }
        
    @objc func getSignleMsg() {
        
        ALF.shared.doGetData(parameters: [:], method: "school_chats/\(self.schoolID)") { response in
        
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [String: Any] {
                            self.chats.append(ChatModel(fromDictionary: data))
                        }
                        self.tblView.reloadData()
                        self.scrollToBottom(height: 0)

                    }
                }
                
            }
            
        } fail: { response in
            
        }
    }
    
    @IBAction func sendTap(_ sender: Any) {
        if !Util.shared.isConnected() {
            self.showTool(msg: "lease check your internet connection!", state: .error)
            return
        }
        if growingTextView.text.count == 0 {
            return
        }
        var tempDic = [String: AnyObject]()
        tempDic["message"] = self.growingTextView.text as AnyObject
        tempDic["type"] = "sender" as AnyObject
        tempDic["admin_id"] = self.schoolID as AnyObject
        print(tempDic)
        self.chats.append(ChatModel(fromDictionary: tempDic))
        self.tblView.reloadData()
        self.scrollToBottom(height: 0)
        growingTextView.text = ""
        DispatchQueue.background(background: {
            
            ALF.shared.doPostData(parameters: tempDic, method: "school_chats", success: { (response) in
                
                print(response)
                
                
            }) { (response) in
            
                print(response)
                
            }
        }, completion:{
            print("Message Finish")
        })
    }

}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = chats[indexPath.row]
        var ident = ""
        var dateStr = ""
        if model.time == nil {
            dateStr = Date().aa_timeAgo(numericDates: true)
        } else {
            dateStr = model.time.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "yyyy-MM-dd HH:mm:ss").aa_toDate(fromFormat: "yyyy-MM-dd HH:mm:ss", currentTimeZone: true)?.aa_timeAgo(numericDates: true) ?? ""
        }
        if model.type == "sender" {
//        if indexPath.row % 2 == 0 {
            ident = "TxtSelfCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: ident) as! ChatCell
            cell.msgView.aa_roundCorners(topLeft: true, topRight: false, bottomLeft: true, bottomRight: true, strokeColor: nil, lineWidth: 0, radius: 12)
            let str = StyledString("\(model.message ?? "")").with(foregroundColor: .white).with(font: UIFont(name: AppFonts.roboto, size: 17)) + StyledString(" - \(dateStr)").with(foregroundColor: .white).with(font: UIFont(name: AppFonts.roboto, size: 12))
            cell.msgLabel.attributedText = str.nsAttributedString
            return cell
        } else {
            ident = "TxtCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: ident) as! ChatCell
            cell.msgView.aa_roundCorners(topLeft: false, topRight: true, bottomLeft: true, bottomRight: true, strokeColor: nil, lineWidth: 0, radius: 12)
            if otherName.count > 2 {
                let newName = String(otherName.getAcronyms().prefix(2))
                cell.nameLbls.text = newName.uppercased()
            } else if otherName.count == 1 {
                let newName = String(otherName.getAcronyms().prefix(1))
                cell.nameLbls.text = newName.uppercased()
            } else {
                cell.nameLbls.text = otherName.getAcronyms().uppercased()
            }

            let str = StyledString("\(model.message ?? "")").with(foregroundColor: .black).with(font: UIFont(name: AppFonts.roboto, size: 17)) + StyledString(" - \(dateStr)").with(foregroundColor: .black.withAlphaComponent(0.5)).with(font: UIFont(name: AppFonts.roboto, size: 12))
            cell.msgLabel.attributedText = str.nsAttributedString
            return cell
        }
        
    }
}
