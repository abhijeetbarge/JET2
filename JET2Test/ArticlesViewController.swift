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
        viewModel.getArticals(pageNo:"\(pageNum)" ) { (isNextPageDataAvailable) in
            self.isNextPageAvailable = isNextPageDataAvailable
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
        if indexPath.row == (viewModel.count - 1) {
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
}

