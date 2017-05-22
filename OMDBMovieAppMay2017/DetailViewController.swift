//
//  RequestResult.swift
//  OMDBMovies
//
//  Created by Ben Smith on 10/05/16.
//  Copyright © 2016 Ben Smith. All rights reserved.
//
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    let size = Size()
    
    
    var detailMovieObject: DetailObject?

    var objects = [DetailObject]() {
        didSet{
            
            tableView.reloadData()
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        registerCells()
        self.tableView.delegate = self
        self.tableView.dataSource = self
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func registerCells() {
        
        let posterCell = UINib(nibName: "FullImageCell", bundle:nil)
        let titleCell = UINib(nibName: "TitleCell", bundle:nil)
        let plotCell = UINib(nibName: "PlotCell", bundle:nil)
        let infoCell = UINib(nibName: "InfoCell", bundle:nil)

        self.tableView.register(posterCell, forCellReuseIdentifier: "fullImageCellID")
        self.tableView.register(titleCell, forCellReuseIdentifier: "titleCellID")
        self.tableView.register(plotCell, forCellReuseIdentifier: "plotCellID")
        self.tableView.register(infoCell, forCellReuseIdentifier: "infoCellID")
    
    }

}
