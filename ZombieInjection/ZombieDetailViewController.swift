//
//  ZombieDetailViewController.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/5/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Bond
import RealmSwift
import UIKit

class ZombieDetailViewController: UIViewController {
    
    @IBOutlet weak var zombieImageView: UIImageView!
    
    @IBOutlet weak var zombieNameTextField: UITextField!
    
    @IBAction func saveAction(_ sender: AnyObject) {
        viewModel.save(unmanagedZombie: unmanagedDetailZombie)
        // Make unmanagedDetailZombie unmanaged again otherwise will get Realm object update errors.
        unmanagedDetailZombie = Zombie(value: unmanagedDetailZombie)
    }
    
    var viewModel: ZombieDetailViewModel!
    var unmanagedDetailZombie: Zombie!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        unmanagedDetailZombie = Zombie(value: self.viewModel.zombie)
        self.viewModel.zombie.image.bind(to: zombieImageView.reactive.image).dispose(in: reactive.bag)
        bindZombieName()
    }
    
    // Need to get rid of the view model to prevent a memory leak.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel = nil
    }
    
    private func bindZombieName() {
        _ = self.unmanagedDetailZombie?.observableName.observeNext {
            event in
            self.zombieNameTextField.text = event
        }
        
        _ = zombieNameTextField.reactive.text.observeNext {
            event in
            if let event = event {
                self.unmanagedDetailZombie?.observableName = Observable(event)
            }
        }
    }
}
