//
//  ImageDownloaderStub.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/15/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Alamofire
import AlamofireImage
import Foundation

class ImageDownloaderMock: ImageDownloader {
    
    public var image = ImageDownloaderMock.createBlackBoxImage()
    
    public var responseIsSuccess = true
    
    override func downloadImage(urlRequest: URLRequestConvertible, receiptID: String, filter: ImageFilter?, progress: ProgressHandler?, progressQueue: DispatchQueue, completion: CompletionHandler?) -> RequestReceipt? {
        
        let response = self.responseIsSuccess ? setupSucessResponse(urlRequest: urlRequest) : setupFailureResponse(urlRequest: urlRequest)
        completion?(response)
        return nil
    }
    
    func setupSucessResponse(urlRequest: URLRequestConvertible) -> Response<Image, NSError> {
        let response = Response<Image, NSError>(request: urlRequest.urlRequest, response: nil, data: nil, result: .success(image))
        return response
    }
    
    func setupFailureResponse(urlRequest: URLRequestConvertible) -> Response<Image, NSError> {
        let error = NSError(domain: "Testing", code: NSURLErrorCancelled, userInfo: nil)
        let response = Response<Image, NSError>(request: urlRequest.urlRequest, response: nil, data: nil, result: .failure(error))
        return response
    }
    
    private static func createBlackBoxImage() -> UIImage {
        let imageSize = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        let rectangle = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        context?.setLineWidth(10)
        context?.setFillColor(UIColor.black.cgColor)
        context?.addRect(rectangle)
        context?.drawPath(using: .fill)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}