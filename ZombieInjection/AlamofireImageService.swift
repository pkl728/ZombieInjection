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
        guard let imageUrlAddress = item.imageUrlAddress else {
            return
        }
        
        guard let imageUrl = URL(string: imageUrlAddress) else {
            return
        }
        let urlRequest = URLRequest(url: imageUrl)
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
