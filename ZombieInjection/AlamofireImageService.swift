//
//  ImageDownloadService.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/12/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Alamofire
import AlamofireImage
import Foundation

protocol ImageDownloadService {
    func requestImage(forItem item: ImageDownloadable)
}

struct AlamofireImageService: ImageDownloadService {
    private let imageDownloader: ImageDownloader
    
    init(imageDownloader: ImageDownloader) {
        self.imageDownloader = imageDownloader
    }
    
    internal func requestImage(forItem item: ImageDownloadable) {
        guard let imageURL = item.imageURL else {
            return
        }
        
        let urlRequest = URLRequest(url: imageURL)
        self.imageDownloader.download(urlRequest) { response in
            if response.result.isFailure {
                print("Problem downloading")
            }
            if let image = response.result.value {
                item.image.value = image
            }
        }
    }
}
