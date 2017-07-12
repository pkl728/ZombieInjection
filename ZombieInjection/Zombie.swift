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
    
    dynamic var id: Int = -1
    dynamic var name: String? = nil
    dynamic var imageUrlAddress: String? = nil
    var image: Observable<UIImage?> = Observable(nil)
    
    var observableName: Observable<String?> {
        get {
            return Observable(name)
        }
        set {
            self.name = newValue.value
        }
    }
    
    convenience init(id: Int, name: String, imageUrlAddress: String?) {
        self.init()
        
        self.id = id
        self.observableName = Observable(name)
        self.imageUrlAddress = imageUrlAddress
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}
