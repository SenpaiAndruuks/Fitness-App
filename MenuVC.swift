//
//  MenuVC.swift
//  Beyond Fit
//
//  Created by Ziad on 01/10/2021.
//

import UIKit

class MenuVC: UIViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
   // @IBAction func settingButtonTapped(_ sender: UIButton) {
      //  dismiss(animated: true, completion: nil)
   // }
    
}
