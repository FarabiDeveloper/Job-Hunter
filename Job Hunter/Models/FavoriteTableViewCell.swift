//
//  FavoriteTableViewCell.swift
//  Job Hunter
//
//  Created by Farabi Bimbetov on 24/04/2019.
//  Copyright © 2019 FarabiCorporation. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var isFavoriteButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyImageView: CustomImageView!
    
    var listener: ((Job) -> ())?

    var job: LittleJob? {
        didSet {
            let isFavImageName = "myFavorite"
            guard let companyLogo = job!.company_logo, companyLogo != ""  else {
                titleLabel.text = job!.title
                locationLabel.text = job!.location
                companyImageView.image = UIImage(named: "job")
                isFavoriteButton.imageView!.image = UIImage(named: isFavImageName)
                return
            }
            titleLabel.text = job!.title
            locationLabel.text = job!.location
            companyImageView.downloaded(from: companyLogo)
            isFavoriteButton.imageView!.image = UIImage(named: isFavImageName)
           
        }
    }
    
    @IBAction func checkFavoriteJob() {
        self.listener!(Job(littleJob: self.job!))
    }
    
    required init?(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
