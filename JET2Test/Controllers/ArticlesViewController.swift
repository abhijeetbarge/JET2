//
//  ArticlesViewController.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    private let viewModel = ArticleTableViewModel()
    private var pageNum = 1
    private var isNextPageAvailable = true
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        self.title = "Articles"
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            viewModel.getArticals(pageNo:"\(pageNum)" ) { (isNextPageDataAvailable) in
                self.isNextPageAvailable = isNextPageDataAvailable
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }else{
            print("Internet Connection not Available!")
            viewModel.getArticalsFromCoreData { (success) in
                           DispatchQueue.main.async {
                               self.tableView.reloadData()
                           }
                       }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destionationViewController = segue.destination as? UserProfileViewController,
            let selectionIndexPath = tableView.indexPathForSelectedRow {
            let article = viewModel.selectedUserProfile(index: selectionIndexPath.row)
            destionationViewController.article = article
        }
    }
    
}

extension ArticlesViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? ArticleTableViewCell else {
                                                        return UITableViewCell()
        }
        
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.count-1) {
            //This is last cell
            print("Last page - \(indexPath.row)")
            pageNum += 1
            if isNextPageAvailable {
                viewModel.getArticals(pageNo:"\(pageNum)" ) { (isNextPageDataAvailable) in
                    self.isNextPageAvailable = isNextPageDataAvailable
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 380
//    }
}

