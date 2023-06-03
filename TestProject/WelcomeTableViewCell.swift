//
//  WelcomeTableViewCell.swift
//  TestProject
//
//  Created by Vignesh S on 03/06/23.
//

import UIKit

class WelcomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    func configureCell(_ welcomeData: WelcomeModel) {
        nameLabel.text = welcomeData.id
        descriptionLabel.text = welcomeData.author
        selectionStyle = .none
    }
    
}
