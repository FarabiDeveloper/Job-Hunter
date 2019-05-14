//
//  FavoritesViewController.swift
//  Job Hunter
//
//  Created by Farabi Bimbetov on 17/04/2019.
//  Copyright © 2019 FarabiCorporation. All rights reserved.
//

import UIKit

struct LittleJob {
    var id: String
    var created_at: String
    var title: String
    var location: String
    var description: String
    var company_logo: String?
}

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var favoriteJobs = [LittleJob]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        self.favoriteJobs = DataBaseService.sharedInstance.readFromDatabase()
        tableView.reloadData()
   
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       updateFavoriteJobsData()
    }
    
    private func updateFavoriteJobsData() {
        self.favoriteJobs = DataBaseService.sharedInstance.readFromDatabase()
        self.tableView.reloadData()
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteJobs.count
    }
    
    func changeFavoriteStatusForJob(job: Job) {
        DataBaseService.sharedInstance.deleteElementById(id: job.id)
        self.favoriteJobs = DataBaseService.sharedInstance.readFromDatabase()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: IndexPath)
        //cell.setup(job: favoriteJobs[indexPath.row], isFavorite: true)
        cell.job = favoriteJobs[indexPath.row]
        
        cell.listener = { [weak self] job in
            self?.changeFavoriteStatusForJob(job: job)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    
}
