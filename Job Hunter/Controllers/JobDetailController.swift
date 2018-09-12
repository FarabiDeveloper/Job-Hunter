//
//  JobDetailController.swift
//  Job Hunter
//
//  Created by Farabi on 12.09.2018.
//  Copyright © 2018 FarabiCorporation. All rights reserved.
//

import UIKit

class JobDetailController: UIViewController {

    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var jobLogo: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var job: Job?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupJobDetails()
        navigationItem.largeTitleDisplayMode = .never
    }

    func setupJobDetails() {
        createdLabel.text = job?.created_at
        locationLabel.text = job?.location
        titleLabel.text = job?.title
        descriptionTextView.text = job?.description
        guard let urlString = job?.company_logo else {
            self.jobLogo.image = UIImage(named: "job")
            return
        }

        if let imageFromCache = imageCache.object(forKey: urlString as NSString)
            as? UIImage {
            self.jobLogo.image = imageFromCache
            return
        }
    }
}
