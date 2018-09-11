//
//  Job.swift
//  Job Hunter
//
//  Created by Farabi on 10.09.2018.
//  Copyright © 2018 FarabiCorporation. All rights reserved.
//

import Foundation

struct Job: Decodable {
    var id: String
    var created_at: String
    var title: String
    var location: String
    var type: String
    var description: String
    var how_to_apply: String
    var company: String
    var company_url: String?
    var company_logo: String?
    var url: String?
    
    init() {
        self.id = ""
        self.created_at = ""
        self.title = ""
        self.location = ""
        self.type = ""
        self.description = ""
        self.how_to_apply = ""
        self.company = ""
        self.company_url = ""
        self.company_logo = ""
        self.url = ""
    }
    
}
