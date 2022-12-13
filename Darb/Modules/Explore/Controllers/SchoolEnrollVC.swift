//
//  SchoolEnrollVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 28/11/2022.
//

import UIKit
import DropDown
import SwiftyJSON

class SchoolEnrollVC: BaseVC {
    
    @IBOutlet weak var schoolName: UITextField!
    @IBOutlet weak var curriculum: UITextField!
    @IBOutlet weak var eduLevelTxt: UITextField!
    @IBOutlet weak var child: UITextField!
    @IBOutlet weak var progressImg: UIImageView!
    
    var eduLevelIndex = -1
    var childIndex = -1
    enum ProgressType {
        case half
        case full
    }
    
    var progTyp = ProgressType.half
    var params = [String: AnyObject]()
    var childs = [Child]()
    var grades = [SchoolGrade]()
    var school: SchoolListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if progTyp == .half {
            setData()
            progressImg.image = UIImage(named: "halfProgress")
            self.getChilds()
            getGradesLevel()
        } else {
            progressImg.image = UIImage(named: "fullProgress")
            setData()
        }
        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navTitle(titel: "School Enrollment Application")
    }
    func setData() {
        if let school {
            schoolName.text = school.name
            curriculum.text = school.offeredCurriculum
            if eduLevelIndex != -1 {
                eduLevelTxt.text = grades[eduLevelIndex].gradeName.capitalized
            }
            
            if childIndex != -1 {
                child.text = childs[childIndex].firstName.capitalized + " " + childs[childIndex].lastName.capitalized
            }
        }
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
    
    func getGradesLevel() {
        self.grades.removeAll()
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: [:], method: "grades?school_id=\(school.id!)") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.grades.append(SchoolGrade(fromDictionary: d))
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
    @IBAction func eduLvlTap(_ sender: UIButton) {
        if progTyp == .full {
            return
        }
        let curiculums = grades.map({$0.gradeName.capitalized})
        let dropDown = DropDown()
        dropDown.dataSource = curiculums
        
        dropDown.anchorView = sender
        dropDown.cellHeight = 51
        
        dropDown.setupCornerRadius(8)
        dropDown.textColor = .black
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 10)
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)! - 10)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            params["grade_id"] = grades[index].id as AnyObject
            self.eduLevelTxt.text = item
            self.eduLevelIndex = index
        }
        if eduLevelIndex != -1 {
            dropDown.selectRow(eduLevelIndex, scrollPosition: .none)
        }
        dropDown.width = sender.frame.width
        dropDown.direction = .any
        dropDown.show()
    }
    
    @IBAction func childTap(_ sender: UIButton) {
        if progTyp == .full {
            return
        }
        let dropDown = DropDown()
        dropDown.dataSource = childs.map({$0.firstName + $0.lastName})
        
        dropDown.anchorView = sender
        dropDown.cellHeight = 51
        
        dropDown.setupCornerRadius(8)
        dropDown.textColor = .black
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 10)
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)! - 10)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            params["child_id"] = childs[index].id as AnyObject
            self.child.text = item
            self.childIndex = index
        }
        if eduLevelIndex != -1 {
            dropDown.selectRow(eduLevelIndex, scrollPosition: .none)
        }
        dropDown.width = sender.frame.width
        dropDown.direction = .any
        dropDown.show()
    }
    
    @IBAction func continueTap(_ sender: Any) {
        if progTyp == .half {
            if eduLevelTxt.aa_isEmpty {
                self.showTool(msg: "School Education Level is required", state: .warning)
                return
            }
            if curriculum.aa_isEmpty {
                self.showTool(msg: "School Curriculum is required", state: .warning)
                return
            }
            let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .schoolEnrollVC) as! SchoolEnrollVC
            params["school_id"] = school.id as AnyObject
            vc.params = params
            vc.childs = self.childs
            vc.grades = self.grades
            vc.childIndex = childIndex
            vc.eduLevelIndex = eduLevelIndex
            vc.school = school
            vc.progTyp = .full
            self.show(vc, sender: self)
        } else {
            Util.shared.showSpinner()
            ALF.shared.doPostData(parameters: params, method: "child_schools") { response in
                Util.shared.hideSpinner()
                print(response)
                DispatchQueue.main.async {
                    let json = JSON(response)
                    if let status = json["status_code"].int {
                        if statusRange.contains(status) {
                            self.showTool(msg: json["message"].string ?? "", state: .success)
                            self.goRootWithDelay()
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
}
