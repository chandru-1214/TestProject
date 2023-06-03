//
//  WelcomeTableViewCell.swift
//  TestProject
//
//  Created by Chandru M on 03/06/23.
//

import UIKit
import SDWebImage

class WelcomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileImageHeightCons: NSLayoutConstraint!
    @IBOutlet weak var profileImageWidthCons: NSLayoutConstraint!
    
    func configureCell(_ welcomeData: WelcomeModel) {
        nameLabel.text = welcomeData.id
        descriptionLabel.text = welcomeData.author
        selectionStyle = .none
        if let url = URL(string: welcomeData.download_url ?? "") {
            profileImageView.sd_setImage(with: url, placeholderImage: UIImage())
        }
//        ImageCache.setImage(imageView: profileImageView, urlString: welcomeData.download_url)
        
        //set Height & width for image
        let imgWidth = welcomeData.imageWidth > maximumImageWidth ? maximumImageWidth :  welcomeData.imageWidth
        let imgHeight = welcomeData.imageHeight > maximumImageWidth ? maximumImageWidth :  welcomeData.imageHeight
        profileImageWidthCons.constant =  CGFloat(imgWidth)
        profileImageHeightCons.constant =  CGFloat(imgHeight)
        
        setCheckBoxView(welcomeData)
    }
    
    func setCheckBoxView(_ welcomeData: WelcomeModel) {
        checkBoxImageView.image = UIImage(named: welcomeData.isSeleceted ? "circle_tick_icon" : "circle_outline_icon")
    }
    
}
