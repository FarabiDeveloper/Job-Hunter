//
//  MainController.swift
//  Job Hunter
//
//  Created by Farabi on 09.09.2018.
//  Copyright © 2018 FarabiCorporation. All rights reserved.
//

import UIKit
import Moya

class MainViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var jobs: [Job] = []
    let hunterProvider = MoyaProvider<Api>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllJobs()
        self.setupNavBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        imageCache.removeAllObjects()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination == "JobDetails" {
//            let destVC = segue.destination as! JobDetailController
//            destVC.jo
//        }
//    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func getAllJobs() {
        self.hunterProvider.request(.searchJobs()) { (result) in
            if let error = result.error {
                self.showAlert(error.localizedDescription)
                return
            }
            switch result {
            case .success(let response):
                do {
                    let convertResponse = try JSONDecoder().decode([Job].self, from: response.data)
                    self.jobs = convertResponse
                    //print("Jobs: \(self.jobs)")
                    self.tableView.reloadData()
                } catch let error {
                    print("error: \(error)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showAlert(_ alertMessage: String)  {
        let alert = UIAlertController.init(title: nil, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let job = jobs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell") as! JobCell
        cell.setup(job: job)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JobDetail") as! JobDetailController
        vc.navigationItem.title = jobs[indexPath.row].company
        vc.job = jobs[indexPath.row]
        //print("vc.shareSerialNumber: \(vc.shopId)")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

