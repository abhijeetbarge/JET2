//
//  ArticleTableViewCell.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    public static let reuseIdentifier = "ArticleCellID"
    
    @IBOutlet weak var userLogo: UIImageView!
    @IBOutlet weak var articleLogo: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDesignationLabel: UILabel!

    @IBOutlet weak var articleContentLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleUrlLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    public var viewModel: ArticleTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            userLogo.maskCircle(url:viewModel.userLogoUrl)
            articleLogo.setImageFromURl(stringImageUrl:viewModel.articleUrl)
            
            userNameLabel.text = viewModel.userName
            userDesignationLabel.text = viewModel.userDesignation
            
            articleContentLabel.text = viewModel.articleContent
            articleTitleLabel.text = viewModel.articleTitle
            articleUrlLabel.text = viewModel.articleUrl
            likesLabel.text = viewModel.likes
            commentLabel.text = viewModel.comment
        }
    }

}

extension UIImageView {
    
    func setImageFromURl(stringImageUrl url: String){
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        //activityIndicator.hidesWhenStopped = true

        DispatchQueue.global(qos: .background).async {
            
            if let url = NSURL(string: url) {
                if let data = NSData(contentsOf: url as URL) {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data as Data)
                        activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    public func maskCircle(url: String) {
        DispatchQueue.global(qos: .background).async {
            
            if let url = NSURL(string: url) {
                if let data = NSData(contentsOf: url as URL) {
                    DispatchQueue.main.async {
                        self.contentMode = UIView.ContentMode.scaleAspectFill
                        self.layer.cornerRadius = self.frame.height / 2
                        self.layer.masksToBounds = false
                        self.clipsToBounds = true
                        self.image = UIImage(data: data as Data)
                    }
                }
            }
        }
    }
}
