//
//  SchoolSubjectsVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 22/11/2022.
//

import UIKit

class SchoolSubjectsVC: BaseVC {

    @IBOutlet weak var tblV: UITableView!
    @IBOutlet weak var shadV: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameLbls: UILabel!
    @IBOutlet weak var grade: UILabel!
    
    var child: Child!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Subjects"
        
        shadV.addShadow(11)
    }
    func setData() {
        let names = "\(child.firstName ?? "") \(child.lastName ?? "")"
        name.text = names
        nameLbls.text = names.getAcronyms().uppercased()
        grade.text = child.grade == nil ? "" : child.grade.gradeName.capitalized
        tblV.reloadData()
    }
}

extension SchoolSubjectsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return child == nil ? 0 : child.subjects.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SubjectCell
        
        return cell
    }
}
