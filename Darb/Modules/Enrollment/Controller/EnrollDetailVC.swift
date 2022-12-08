//
//  EnrollDetailVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 30/11/2022.
//

import UIKit
import SwiftyJSON

class EnrollDetailVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var colV: UICollectionView!
    
    var enroll: Child!
    
    var sec1 = [[String: String]]()
    var sec2 = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Enrollment details"
        
        setupData()
    }
    
    func setupData() {
        var dic = [String: String]()
        if enroll.school != nil {
            if enroll.school.name != nil {
                dic["name"] = enroll.school.name
                dic["title"] = "School Name"
                sec1.append(dic)
            }
            if enroll.school.offeredCurriculum != nil {
                dic["name"] = enroll.school.offeredCurriculum
                dic["title"] = "School Curriculum"
                sec1.append(dic)
            }
            if enroll.school.levelOfEducation != nil {
                dic["name"] = enroll.school.levelOfEducation
                dic["title"] = "School Education Level"
                sec1.append(dic)
            }
        }
       
        
        if enroll.firstName != nil {
            dic["name"] = enroll.firstName
            dic["title"] = "First Name"
            sec2.append(dic)
        }
        if enroll.lastName != nil {
            dic["name"] = enroll.lastName
            dic["title"] = "Last Name"
            sec2.append(dic)
        }
        if enroll.dob != nil {
            dic["name"] = enroll.dob
            dic["title"] = "Birthdate"
            sec2.append(dic)
        }
        if enroll.nationalId != nil {
            dic["name"] = enroll.nationalId
            dic["title"] = "National ID Number"
            sec2.append(dic)
        }
        if enroll.birthCertificate != nil {
            dic["name"] = enroll.birthCertificate.name
            dic["title"] = "Birth Certificate"
            sec2.append(dic)
        }
        if enroll.portraitPhoto != nil {
            dic["name"] = enroll.portraitPhoto.name
            dic["title"] = "Portrait Photo"
            sec2.append(dic)
        }
        if enroll.healthReport != nil {
            dic["name"] = enroll.healthReport.name
            dic["title"] = "Health Report"
            sec2.append(dic)
        }
        
        colV.reloadData()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if sec1.isEmpty {
            return 1
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sec1.isEmpty {
            return sec2.count
        }
        if section == 0 {
            return sec1.count
        } else {
            return sec2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SimpleHeaderV", for: indexPath) as! SimpleHeaderV
            if sec1.isEmpty {
                headerView.headTitle.text = "School Information"
            } else {
                if indexPath.section == 0 {
                    headerView.headTitle.text = "School Information"
                } else {
                    headerView.headTitle.text = "Student Information"
                }
            }
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footV", for: indexPath) as! SimpleHeaderV
            
//            footerView.backgroundColor = UIColor.green
            return footerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if sec1.isEmpty {
            return CGSize(width: collectionView.frame.width/2 - 10, height: 44)
        } else {
            if indexPath.section == 0 {
                return CGSize(width: collectionView.frame.width, height: 44)
            } else {
                return CGSize(width: collectionView.frame.width/2 - 10, height: 44)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChildDetailCell", for: indexPath) as! ChildDetailCell
        if sec1.isEmpty {
            cell.fName.text = sec2[indexPath.item]["title"]
            cell.lName.text = sec2[indexPath.item]["name"]
        } else {
            if indexPath.section == 0 {
                cell.fName.text = sec1[indexPath.item]["title"]
                cell.lName.text = sec1[indexPath.item]["name"]
            } else {
                cell.fName.text = sec2[indexPath.item]["title"]
                cell.lName.text = sec2[indexPath.item]["name"]
            }
        }
        return cell
    }

    @IBAction func cancelEnrollTap(_ sender: Any) {
        
        Util.shared.showSpinner()
        ALF.shared.doDeleteData(parameters: [:], method: "child_schools/\(enroll.id!)") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        self.showTool(msg: json["message"].string ?? "", state: .success)
                        self.goBackWithDelay()
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
