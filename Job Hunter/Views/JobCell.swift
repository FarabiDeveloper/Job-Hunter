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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(job: Job) {
        guard let companyLogo = job.company_logo, companyLogo != ""  else {
            self.title.text = job.title
            self.location.text = job.location
            //var image = UIImage(named: "job")!
            self.jobImage.image = UIImage(named: "job")
            //self.jobImage = UIImageView(image: image) as! CustomImageView
            return
        }
        self.jobImage.downloaded(from: companyLogo)
        print("companyLogo: \(job.company_logo)")
        self.title.text = job.title
        self.location.text = job.location
    }

}
