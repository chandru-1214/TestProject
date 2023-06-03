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

        print("SplashViewController >>>>>>")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Timer.scheduledTimer(timeInterval: 0,
                                         target: self,
                                         selector: #selector(chekNavigation),
                                         userInfo: nil,
                                         repeats: false)
    }
    
    @objc func chekNavigation(){
        print("chekNavigation")
        DispatchQueue.main.async {
            if let welcomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController {
                self.navigationController?.pushViewController(welcomeViewController, animated: true)
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = tabBarController
            }else{
                print("welcomeViewController error")
                }
            
//            appDelegate.window?.makeKeyAndVisible()
//            UIApplication.shared.keyWindow?.rootViewController = tabBarController
//            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
