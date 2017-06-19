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
        
        viewModel.zombie.image.bind(to: zombieImageView.reactive.image).dispose(in: reactive.bag)
        viewModel.zombie.observableName.bidirectionalBind(to: zombieNameTextField.reactive.text).dispose(in: reactive.bag)
    }
    
    // Need to get rid of the view model to prevent a memory leak.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel = nil
    }
}
