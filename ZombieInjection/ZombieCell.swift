//
//  ZombieCell.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/5/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import UIKit
import Bond

class ZombieCell: UITableViewCell {
    
    @IBOutlet weak var zombieImageView: UIImageView!
    @IBOutlet weak var zombieNameLabel: UILabel!
    
    static let cellIdentifier = "ZombieCell"
    
    // MARK: View Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reactive.bag.dispose()
    }
}
