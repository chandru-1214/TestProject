//
//  BaseViewController.swift
//  TestProject
//
//  Created by Vignesh S on 03/06/23.
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
    
}
