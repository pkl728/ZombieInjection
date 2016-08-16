//
//  ZombieDetailViewController.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/5/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Bond
import UIKit

class ZombieDetailViewController: UIViewController {
    
    @IBOutlet weak var zombieImageView: UIImageView!
    
    @IBOutlet weak var zombieNameTextField: UITextField!
    
    @IBAction func saveAction(_ sender: AnyObject) {
        viewModel.save()
    }
    
    var viewModel: ZombieDetailViewModel!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.zombie.image.bindTo(zombieImageView.bnd_image).disposeIn(bnd_bag)
        viewModel.zombie.name.bidirectionalBindTo(zombieNameTextField.bnd_text).disposeIn(bnd_bag)
    }
    
    // Need to get rid of the view model to prevent a memory leak.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel = nil
    }
}
