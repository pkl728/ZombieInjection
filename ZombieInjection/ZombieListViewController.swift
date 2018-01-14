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
    
    var viewModel: ZombieListViewModel!
    
    private var dataSource = ObservableArray<Zombie>()
    
    @IBOutlet weak var zombieTableView: UITableView!

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateZombieList()
        self.dataSource = viewModel.tableMembers
        
        createBindings()
        
        zombieTableView.delegate = self
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "ShowZombieDetails") {
            let indexPath = self.zombieTableView.indexPathForSelectedRow
            let zombie = viewModel.tableMembers[(indexPath! as NSIndexPath).row]
            let detailViewController = segue.destination as! ZombieDetailViewController
            detailViewController.viewModel = ZombieDetailViewModel(zombie: zombie,
                                                                   zombieService: viewModel.zombieService,
                                                                   goBackCallBack: {
                                                                    var _ = detailViewController.navigationController?.popViewController(animated: true)
                                                                    //self.zombieTableView.reloadData()
            }
            )
        }
    }
    
    // MARK: Binding
    
    func createBindings() {
        dataSource.bind(to: self.zombieTableView) {
            dataSource, indexPath, tableView in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ZombieCell.cellIdentifier, for: indexPath) as! ZombieCell
            let zombie = dataSource[(indexPath as NSIndexPath).row]
            self.viewModel.imageDownloadService.requestImage(forItem: zombie)
            zombie.name.bind(to: cell.zombieNameLabel.reactive.text).dispose(in: cell.reactive.bag)
            zombie.image.bind(to: cell.zombieImageView.reactive.image).dispose(in: cell.reactive.bag)
            return cell
        }.dispose(in: reactive.bag)
    }
}
