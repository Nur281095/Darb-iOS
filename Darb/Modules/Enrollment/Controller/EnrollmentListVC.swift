//
//  EnrollmentListVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 23/11/2022.
//

import UIKit
import StyledString

class EnrollmentListVC: BaseVC {
    
    @IBOutlet weak var colV: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Enrollment Application"
    }
    
}

extension EnrollmentListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 298)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EnrollListCell", for: indexPath) as! EnrollListCell
        DispatchQueue.main.async {
            cell.shadV.addShadow(12)
        }
        let str = StyledString("Processing").with(foregroundColor: UIColor(hexString: "#DF9401")).with(font: UIFont(name: AppFonts.roboto, size: 13)).with(backgroundColor: UIColor(hexString: "#FFC33E").withAlphaComponent(0.20))
        cell.statusBtn.setAttributedTitle(str.nsAttributedString, for: .normal)
        return cell
    }
}
