//
//  ImageDownloadable.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 8/12/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Bond
import Foundation

protocol ImageDownloadable {
    var imageUrlAddress: String? { get set }
    var image: Observable<UIImage?> { get set }
}
