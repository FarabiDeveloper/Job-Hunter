//
//  Api.swift
//  Job Hunter
//
//  Created by Farabi on 11.09.2018.
//  Copyright © 2018 FarabiCorporation. All rights reserved.
//


import Foundation
import Moya
import Result
import SwiftyJSON

enum Api {
    case searchJobs(info: SearchInfo)
}

extension Api: TargetType {
   static var provider = MoyaProvider<Api>()
    
    var baseURL: URL {
        return URL(string: "https://jobs.github.com/")!
    }
    
    var path: String {
        switch self {
        case .searchJobs(_):
           return "positions.json"
        }
    }
    
    var method: Moya.Method {
        switch  self {
        default:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return ["Content-Typer" : "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .searchJobs(let info):
            let params: [String : Any] = ["search" : info.search, "page" : info.page]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
}
