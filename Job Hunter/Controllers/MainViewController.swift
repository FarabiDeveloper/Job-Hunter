//
//  MainController.swift
//  Job Hunter
//
//  Created by Farabi on 09.09.2018.
//  Copyright © 2018 FarabiCorporation. All rights reserved.
//

import UIKit
import Moya

class MainViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var jobs: [Job] = []
    var filteredJobs: [Job] = []
    var isSearching = false
    let hunterProvider = MoyaProvider<Api>()
    let searchController = UISearchController(searchResultsController: nil)
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBar text: \(String(describing: searchBar.text))")
        self.isSearching = true
        guard let keywords = searchBar.text else {
            return
        }
        if keywords == "" {
            // обработать случай когда текст в поиске пустой

        }
        self.filteredJobs = jobs.filter { $0.title.contains(keywords)}
        tableView.reloadData()
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = false
        self.tableView.reloadData()
    }
    //for testing
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false;
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllJobs()
        self.setupNavBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        imageCache.removeAllObjects()
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getAllJobs() {
        let params = SearchInfo.init(search: "java", page: 0)
        self.hunterProvider.request(.searchJobs(info: params)) { (result) in
            if let error = result.error {
                self.showAlert(error.localizedDescription)
                return
            }
            switch result {
            case .success(let response):
                do {
                    let jobsResponse = try JSONDecoder().decode([Job].self, from: response.data)
                    self.jobs = jobsResponse
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
        if isSearching {
            return filteredJobs.count
        } else {
            return jobs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell") as! JobCell
        var job = Job()
        if isSearching {
            job = filteredJobs[indexPath.row]
        } else {
            job = jobs[indexPath.row]
        }
        cell.setup(job: job)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JobDetail") as! JobDetailController
        vc.navigationItem.title = jobs[indexPath.row].company
        vc.job = jobs[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

