//
//  JobDetailController.swift
//  Job Hunter
//
//  Created by Farabi on 12.09.2018.
//  Copyright © 2018 FarabiCorporation. All rights reserved.
//

import UIKit
import Kanna

class JobDetailController: UIViewController {

    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var jobLogo: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var job: Job?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupJobDetails()
//        let backButton = UIBarButtonItem.init(image: UIImage(named: "back_button"),
//                                              style: .plain,
//                                              target: self,
//                                              action: #selector(self.actionDismiss(_:)) )
//        backButton.tintColor = UIColor.blue
//        self.navigationItem.leftBarButtonItems?.removeAll()
//        self.navigationItem.leftBarButtonItem = backButton
//
        self.title = job?.company
        navigationItem.largeTitleDisplayMode = .never
    }
    
//    @objc func actionDismiss(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }

    func setupJobDetails() {
        createdLabel.text = job?.created_at
        locationLabel.text = job?.location
        titleLabel.text = job?.title
        
        let html = job?.description
        var descriptionVariable = ""
        if let doc = try? HTML(html: html!, encoding: .utf8) {
            guard let text = doc.text else { return }
            descriptionVariable = text
        }
        descriptionLabel.text = descriptionVariable
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
