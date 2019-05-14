//
//  UIImageViewExtensions.swift
//  Job Hunter
//
//  Created by Farabi on 11.09.2018.
//  Copyright © 2018 FarabiCorporation. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, AnyObject>()

class CustomImageView: UIImageView {
    var imageUrlString: String?
    
    func downloaded(from urlString: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        imageUrlString = urlString
        let url = URL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString)
            as? UIImage {
            self.image = imageFromCache
            return
        }
        DispatchQueue.global().async() {
            URLSession.shared.dataTask(with: url!) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    let imageToCache = image
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                }
                }.resume()
        }
    }
}
