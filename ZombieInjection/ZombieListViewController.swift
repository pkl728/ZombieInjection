//
//  ViewController.swift
//  ZombieInjection
//
//  Created by Patrick Lind on 7/5/16.
//  Copyright © 2016 Patrick Lind. All rights reserved.
//

import Bond
import Dip
import AlamofireImage
import UIKit

class ZombieListViewController: UIViewController, UITableViewDelegate {
    
    let viewModel = ZombieListViewModel()
    
    private var dataSource = ObservableArray<ObservableArray<Zombie>>()
    
    @IBOutlet weak var zombieTableView: UITableView!

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateZombieList()
        self.dataSource = viewModel.tableMembers.lift()
        
        createBindings()
        
        zombieTableView.delegate = self
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "ShowZombieDetails") {
            let indexPath = self.zombieTableView.indexPathForSelectedRow
            let zombie = viewModel.tableMembers[(indexPath! as NSIndexPath).row]
            let detailViewController = segue.destination as! ZombieDetailViewController
            detailViewController.viewModel = ZombieDetailViewModel(zombie: zombie,
                                                                   zombieService: viewModel.zombieService,
                                                                   goBackCallBack: {var _ = detailViewController.navigationController?.popViewController(animated: true)} )
        }
    }
    
    // MARK: Binding
    
    func createBindings() {
        dataSource.bindTo(self.zombieTableView) {
            indexPath, dataSource, tableView in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ZombieCell.cellIdentifier, for: indexPath) as! ZombieCell
            let zombie = dataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
            self.viewModel.imageDownloadService.requestImage(forItem: zombie)
            zombie.name.bindTo(cell.zombieNameLabel.bnd_text).disposeIn(cell.bnd_bag)
            zombie.image.bindTo(cell.zombieImageView.bnd_image).disposeIn(cell.bnd_bag)
            return cell
        }.disposeIn(bnd_bag)
    }
}

