//
//  Zombie.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/5/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Bond
import UIKit
import Realm
import RealmSwift

public class Zombie: Object, Persistable, ImageDownloadable {
    
    var id: Int = -1
    var name: Observable<String?> = Observable(nil)
    var imageUrlAddress: String? = nil
    var image: Observable<UIImage?> = Observable(nil)
    
    convenience init(id: Int, name: String, imageUrlAddress: String?) {
        self.init()
        
        self.id = id
        self.name = Observable(name)
        self.imageUrlAddress = imageUrlAddress
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}
