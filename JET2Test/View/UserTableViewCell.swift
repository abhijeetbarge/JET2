//
//  UserTableViewCell.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 15/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    public static let reuseIdentifier = "UserCellID"
    @IBOutlet weak var userLogo: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDesignationLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    public var viewModel: UserTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            userLogo.maskCircle(url:viewModel.userLogoUrl)
            userNameLabel.text = viewModel.userName
            userDesignationLabel.text = viewModel.userDesignation
            cityLabel.text = viewModel.userCity
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
