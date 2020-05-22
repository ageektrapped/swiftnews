//
//  ImageManager.swift
//  SwiftNews
//
//  Created by JasonK on 2020-05-21.
//  Copyright © 2020 JasonKemp. All rights reserved.
//

import Foundation
import UIKit

protocol ImageSource {
    var imageURL: URL? { get }
}

private let manager = ImageManager(networkManager: NetworkManager())

class ImageManager {
    
    let networkManager:  NetworkManager
    let cache: NSCache<NSURL, UIImage>
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.cache = NSCache<NSURL, UIImage>()
    }
    
    func loadImage(_ url: URL, completion: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: url as NSURL) {
            completion(image)
            return
        }
        networkManager.fetch(url) { [weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self?.cache.setObject(image, forKey: url as NSURL)
                        completion(image)
                    }
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}

extension UIImageView {
    func loadImage(_ imageSource: ImageSource) {
        guard let url = imageSource.imageURL else { return }
        manager.loadImage(url) { image in
            // add image to cache
            self.image = image
        }
    }
}

extension Article: ImageSource {
    
}
