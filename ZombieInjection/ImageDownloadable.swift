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
    var imageURL: URL? { get set }
    var image: Observable<UIImage?> { get set }
}
