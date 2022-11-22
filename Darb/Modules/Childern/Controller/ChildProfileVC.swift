//
//  ChildProfileVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 22/11/2022.
//

import UIKit

class ChildProfileVC: BaseVC {

    @IBOutlet weak var colV: UICollectionView!
    
    var child: Child!
    var arrayOfDic = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.rightBarButtonItem = btnRight(image: "ic_edit", isOrignal: false)
        self.navigationItem.title = "Child Profile"
        setupData()
    }
    

    override func btnRightAction(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .child).loadViewController(withIdentifier: .addChildVC) as! AddChildVC
        vc.isAdd = false
        vc.child = child
        self.show(vc, sender: self)
    }
    
    func setupData() {
        var dic = [String: String]()
        if child.firstName != nil {
            dic["name"] = child.firstName
            dic["title"] = "First Name"
            arrayOfDic.append(dic)
        }
        if child.lastName != nil {
            dic["name"] = child.lastName
            dic["title"] = "Last Name"
            arrayOfDic.append(dic)
        }
        if child.dob != nil {
            dic["name"] = child.dob
            dic["title"] = "Birthdate"
            arrayOfDic.append(dic)
        }
        if child.nationalId != nil {
            dic["name"] = child.nationalId
            dic["title"] = "National ID Number"
            arrayOfDic.append(dic)
        }
        if child.birthCertificate != nil {
            dic["name"] = child.birthCertificate
            dic["title"] = "Birth Certificate"
            arrayOfDic.append(dic)
        }
        if child.portraitPhoto != nil {
            dic["name"] = child.portraitPhoto
            dic["title"] = "Portrait Photo"
            arrayOfDic.append(dic)
        }
        if child.healthReport != nil {
            dic["name"] = child.healthReport
            dic["title"] = "Health Report"
            arrayOfDic.append(dic)
        }
        self.colV.reloadData()
    }
}

extension ChildProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfDic.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2) - 10, height: 45)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChildDetailCell", for: indexPath) as! ChildDetailCell
        let model = arrayOfDic[indexPath.item]
        cell.fName.text = model["title"]
        cell.lName.text = model["name"]
//        cell.lName.set(image: UIImage(named: "ic_doc_ico")!, with: " Sarah.pdf")
        return cell
    }
}
