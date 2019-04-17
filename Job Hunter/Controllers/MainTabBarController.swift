//
//  MainTabBarController.swift
//  Job Hunter
//
//  Created by Farabi Bimbetov on 14/04/2019.
//  Copyright © 2019 FarabiCorporation. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)
        
        // Do any additional setup after loading the view.
    }
    
    

}
