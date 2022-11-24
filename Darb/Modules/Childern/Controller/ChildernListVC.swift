//
//  ChildernListVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 22/11/2022.
//

import UIKit
import SwiftyJSON

class ChildernListVC: BaseVC {

    @IBOutlet weak var selecVLead: NSLayoutConstraint!
    @IBOutlet weak var tblV: UITableView!
    
    @IBOutlet weak var addBtn: UIButton!
    
    
    enum TapType {
        case child
        case school
    }
    
    var tabTyp = TapType.child
    var childs = [Child]()
    var schools = [Child]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBtn.setTitle("", for: .normal)
        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "My children"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getChilds()
    }
    
    func getChilds() {
        self.childs.removeAll()
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: [:], method: "childs") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.childs.append(Child(fromDictionary: d))
                            }
                        }
                        self.tblV.reloadData()

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
    
    func getSchools() {
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: [:], method: "schools?lat=24.7564552&lang=46.7037408") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.childs.append(Child(fromDictionary: d))
                            }
                        }
                        self.tblV.reloadData()

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
    
    @IBAction func childTap(_ sender: Any) {
        tabTyp = .child
        addBtn.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.selecVLead.constant = 0
        }
        if self.childs.isEmpty {
            self.getChilds()
        } else {
            tblV.reloadData()
        }
    }
    
    @IBAction func schoolTap(_ sender: Any) {
        tabTyp = .school
        addBtn.isHidden = true
        tblV.reloadData()
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.selecVLead.constant = self.view.frame.width/2
        }
        if self.schools.isEmpty {
            self.getSchools()
        } else {
            tblV.reloadData()
        }
    }
    
    @IBAction func addTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .child).loadViewController(withIdentifier: .addChildVC) as! AddChildVC
        vc.isAdd = true
        self.show(vc, sender: self)
    }
    
}

extension ChildernListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabTyp == .child ? childs.count : schools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tabTyp == .child ? 111 : 183
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tabTyp == .child {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCell") as! ChildCell
            DispatchQueue.main.async {
                cell.shadV.addShadow(10)
            }
            let name = "\(childs[indexPath.row].firstName ?? "") \(childs[indexPath.row].lastName ?? "")"
            cell.name.text = name
            cell.nameLbls.text = name.getAcronyms().uppercased()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell") as! SchoolCell
            DispatchQueue.main.async {
                cell.shadV.addShadow(10)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tabTyp == .child {
            let vc = UIStoryboard.storyBoard(withName: .child).loadViewController(withIdentifier: .childProfileVC) as! ChildProfileVC
            vc.child = childs[indexPath.row]
            self.show(vc, sender: self)
        } else {
            let vc = UIStoryboard.storyBoard(withName: .child).loadViewController(withIdentifier: .schoolSubjectsVC) as! SchoolSubjectsVC
            self.show(vc, sender: self)
        }
    }
}
