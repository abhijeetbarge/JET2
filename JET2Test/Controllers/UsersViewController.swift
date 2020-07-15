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
    private var isNextPageAvailable = true
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Users"
        viewModel.getUsers(pageNo: "1") { (isNextPageDataAvailable) in
            self.isNextPageAvailable = isNextPageDataAvailable
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
            if isNextPageAvailable {
                viewModel.getUsers(pageNo:"\(pageNum)" ) { (isNextPageDataAvailable) in
                    self.isNextPageAvailable = isNextPageDataAvailable
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}



