//
//  Zombie.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/5/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Bond
import UIKit

public struct Zombie: Persistable, ImageDownloadable {
    
    var id: Int
    var name: Observable<String?>
    var imageURL: URL?
    var image: Observable<UIImage?>
    
    init(id: Int, name: String, imageURL: URL?) {
        self.id = id
        self.name = Observable(name)
        self.image = Observable<UIImage?>(nil)
        self.imageURL = imageURL
    }
}
