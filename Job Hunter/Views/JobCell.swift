//
//  JobCell.swift
//  Job Hunter
//
//  Created by Farabi on 10.09.2018.
//  Copyright © 2018 FarabiCorporation. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    @IBOutlet weak var jobImage: CustomImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    func setup(job: Job, isFavorite: Bool = false) {
        let isFavImageName = (isFavorite) ? ("myFavorite") : ("isFavorite")
        guard let companyLogo = job.company_logo, companyLogo != ""  else {
            self.title.text = job.title
            self.location.text = job.location
            self.jobImage.image = UIImage(named: "job")
            self.favoriteImage.image = UIImage(named: isFavImageName)
            return
        }
        self.jobImage.downloaded(from: companyLogo)
        self.title.text = job.title
        self.location.text = job.location
        self.favoriteImage.image = UIImage(named: isFavImageName)
        //DataBaseService.readFromDatabase(DataBaseService)
    }
    func setup(job: LittleJob, isFavorite: Bool = false) {
        let isFavImageName = (isFavorite) ? ("myFavorite") : ("isFavorite")
        guard let companyLogo = job.company_logo, companyLogo != ""  else {
            self.title.text = job.title
            self.location.text = job.location
            self.jobImage.image = UIImage(named: "job")
            self.favoriteImage.image = UIImage(named: isFavImageName)
            return
        }
        self.jobImage.downloaded(from: companyLogo)
        self.title.text = job.title
        self.location.text = job.location
        self.favoriteImage.image = UIImage(named: isFavImageName)
        //DataBaseService.readFromDatabase(DataBaseService)
    }

}
