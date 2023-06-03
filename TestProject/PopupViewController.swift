//
//  PopupViewController.swift
//  TestProject
//
//  Created by Vignesh S on 03/06/23.
//

import UIKit

protocol PopupViewControllerDelegate: AnyObject {
    func leftTapAction(_ welcomeData: WelcomeModel)
    func rightTapAction(_ welcomeData: WelcomeModel)
}

class PopupViewController: UIViewController {
    
    

    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    var welcomeData = WelcomeModel()
    
    weak var delegate: PopupViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    private func configureUI() {
        if welcomeData.isSeleceted {
            selectLabel.isHidden = true
            messageLabel.text = "Do you want to deselect \(welcomeData.author ?? "")"
        } else {
            selectLabel.isHidden = false
            messageLabel.text = "Would you like to select the \(welcomeData.author ?? "")"
        }
    }
    
    
    @IBAction func actionOnDismissButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionOnNoButton(_ sender: Any) {
        delegate?.leftTapAction(welcomeData)
        self.dismiss(animated: true)
    }
    
    @IBAction func actionOnYesButton(_ sender: Any) {
        delegate?.rightTapAction(welcomeData)
        self.dismiss(animated: true)
    }
}
