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
    var imageUrl: URL?
    var image: Observable<UIImage?>
    
    init(id: Int, name: String, imageUrlAddress: String?) {
        self.id = id
        self.name = Observable(name)
        self.image = Observable<UIImage?>(nil)
        if imageUrlAddress != nil {
            self.imageUrl = URL(string: imageUrlAddress!)
        }
        else {
            self.imageUrl = nil
        }
    }
}
