//
//  UsersViewController.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    private let viewModel = UserTableViewModel()
    private var pageNum = 1
    private var totalPages = 5
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        self.title = "Users"
        if Reachability.isConnectedToNetwork(){
            
            viewModel.getUsers(pageNo: "1") { () in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }else{
            viewModel.getUsersFromCoreData { (success) in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}


extension UsersViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? UserTableViewCell else {
                                                        return UITableViewCell()
        }
        
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        cell.viewModel = cellViewModel
        if indexPath.row == (viewModel.count - 1) {
            //This is last cell
            print("Last page - \(indexPath.row)")
            pageNum += 1
            if pageNum <= totalPages {
                viewModel.getUsers(pageNo:"\(pageNum)" ) { () in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        return cell
    }
}



