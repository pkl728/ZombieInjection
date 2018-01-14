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

public class Zombie: ImageDownloadable, RealmPersistable {
    typealias RealmObject = ZombieRealmObject
    
    var id: Int = -1
    var name: Observable<String?>
    var imageUrlAddress: String?
    var image: Observable<UIImage?> = Observable(nil)
    
    var realmObject: RealmObject
    
    static var objectType: RealmObject.Type { return RealmObject.self }
    
    init(id: Int, name: String?, imageUrlAddress: String?) {
        self.id = id
        self.name = Observable(name)
        self.imageUrlAddress = imageUrlAddress 
        self.realmObject = ZombieRealmObject(id: self.id, name: self.name.value, imageUrlAddress: self.imageUrlAddress)
    }
}

protocol RealmPersistable: Persistable {
    associatedtype RealmObject: Object, Persistable, RealmValueProtocol
    
    var realmObject: RealmObject { get set }
}

protocol RealmValueProtocol {
    func originalValue() -> RealmPersistable
}

public class ZombieRealmObject: Object, Persistable, RealmValueProtocol {
    
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String? = nil
    @objc dynamic var imageUrlAddress: String? = nil
    
    convenience init(id: Int, name: String?, imageUrlAddress: String?) {
        self.init()
        
        self.id = id
        self.name = name
        self.imageUrlAddress = imageUrlAddress
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    func originalValue() -> RealmPersistable {
        return Zombie(id: self.id, name: self.name, imageUrlAddress: self.imageUrlAddress)
    }
}
