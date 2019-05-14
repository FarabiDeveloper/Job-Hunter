//
//  Database.swift
//  Job Hunter
//
//  Created by Farabi Bimbetov on 17/04/2019.
//  Copyright © 2019 FarabiCorporation. All rights reserved.
//

import Foundation
import GRDB

class DataBaseService: NSObject {
    
    static let sharedInstance = DataBaseService()
    var dbQueue: DatabaseQueue?
    
    
//    createdLabel.text = job?.created_at
//    locationLabel.text = job?.location
//    titleLabel.text = job?.title
//
//    let html = job?.description
//    var descriptionVariable = ""
//    if let doc = try? HTML(html: html!, encoding: .utf8) {
//        guard let text = doc.text else { return }
//        descriptionVariable = text
//    }
//    descriptionLabel.text = descriptionVariable
//    guard let urlString = job?.company_logo else {
//    self.jobLogo.image = UIImage(named: "job")
//    return
//    }

    
    override init() {
        do {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let pathToDatabaseFile = "\(documentsPath)/database.sqlite"
            self.dbQueue = try DatabaseQueue(path: pathToDatabaseFile)
            try self.dbQueue?.inDatabase { db in
                try db.execute(
                    "CREATE TABLE IF NOT EXISTS FavoritesJobs (" +
                        "id STRING PRIMARY KEY, " +
                        "create_at STRING NOT NULL, " +
                        "location STRING NOT NULL, " +
                        "title STRING NOT NULL, " +
                        "description STRING NOT NULL," +
                        "imageURL STRING NOT NULL" +
                    ")")
            }
        } catch {
            NSLog("Failed to create database")
        }
    }

    func readFromDatabase() -> [LittleJob] {
        var jobs = [LittleJob]()
        do {
            try self.dbQueue?.inDatabase { db in
                let rows = try Row.fetchCursor(db, "SELECT * FROM FavoritesJobs")
                while let row = try rows.next() {
                    
                    let id: String = row["id"]
                    let create_at: String = row["create_at"]
                    let location: String = row["location"]
                    let title: String = row["title"]
                    let description: String = row["description"]
                    let imageURL: String = row["imageURL"]
                    
                    let newJob = LittleJob(id: id, created_at: create_at, title: title, location: location, description: description, company_logo: imageURL)
                    jobs.append(newJob)
                    //NSLog("id: \(id), create_at: \(create_at), location: \(location), title: \(title), description: \(description), imageURL: \(imageURL)");
                }
                
                //let poiCount = try Int.fetchOne(db, "SELECT COUNT(*) FROM FavoritesJobs")! // Int
                
                //let poiUID = try String.fetchAll(db, "SELECT uid, title FROM FavoritesJobs") // [String]
                
                //NSLog("poiCount: \(poiCount), poiUID: \(poiUID)")
                
            }
            // Extraction
            let poiCount = try dbQueue?.inDatabase { db in
                try Int.fetchOne(db, "SELECT COUNT(*) FROM FavoritesJobs")!
            }
        } catch {
            NSLog("Failed to read from database")
        }
        return jobs
    }
    
    
    func deleteElementById(id: String) {
        do {
            try self.dbQueue?.inDatabase { db in
                let sqlRequest = "DELETE FROM FavoritesJobs WHERE id = \(id)"
                try db.execute(sqlRequest)
                
            }
        } catch {
            NSLog("Failed to delete element from db by id")
        }
    }
    
    func writeToDatabase(newJob: Job) {
        do {
            try self.dbQueue?.inDatabase { db in
                var checkedJob = false
                let AllJobsFromDB = try String.fetchAll(db, "SELECT id FROM FavoritesJobs") // [String]
                for element in AllJobsFromDB {
                    if element == newJob.id {
                        checkedJob = true
                    }
                }
                if !checkedJob{
                    try db.execute(
                        "INSERT INTO FavoritesJobs (id, create_at, location, title, description, imageURL) " +
                        "VALUES (?, ?, ?, ?, ?, ?)",
                        arguments: [newJob.id, newJob.created_at, newJob.location, newJob.title, newJob.description, newJob.company_logo])
                }
            }
        } catch {
            NSLog("Failed to insert a new row to database")
        }
    }
}

