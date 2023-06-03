//
//  BaseViewController.swift
//  TestProject
//
//  Created by Chandru M on 03/06/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func showNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
}
