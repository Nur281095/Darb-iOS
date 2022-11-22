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
    @IBOutlet weak var nameLbls: UILabel!
    @IBOutlet weak var grade: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Subjects"
        
        shadV.addShadow(11)
    }
    
}

extension SchoolSubjectsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SubjectCell
        
        return cell
    }
}
