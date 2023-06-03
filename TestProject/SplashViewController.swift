//
//  SplashViewController.swift
//  TestProject
//
//  Created by Chandru M on 03/06/23.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setting timer for 5 sec
        Timer.scheduledTimer(timeInterval: 5,
                                         target: self,
                                         selector: #selector(chekNavigation),
                                         userInfo: nil,
                                         repeats: false)
    }
    
    @objc func chekNavigation(){
        DispatchQueue.main.async {
            if let welcomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController {
                self.navigationController?.pushViewController(welcomeViewController, animated: true)
            } else {
                print("welcomeViewController error")
            }
        }
    }

}
