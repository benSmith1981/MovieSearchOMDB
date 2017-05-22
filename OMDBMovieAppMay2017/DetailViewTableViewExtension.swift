//
//  RequestResult.swift
//  OMDBMovies
//
//  Created by Ben Smith on 10/05/16.
//  Copyright © 2016 Ben Smith. All rights reserved.
//
import UIKit
import Kingfisher

extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            if let count = detailMovieObject?.dictionaryRepresentation().count {
                return count
            } else {
                return 1
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Parameters.detailView.sections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            
            return size.percentage(of:
                view.frame.height,
                percentage: Parameters.detailView.row1CellHeightInPercentage)
            
        case 1:
            return size.percentage(of:
                view.frame.height,
                percentage: Parameters.detailView.row2CellHeightInPercentage)
            
        case 2:
            return 100
            
        default:
            return size.percentage(of:
                view.frame.height,
                percentage: Parameters.detailView.row3CellHeightInPercentage)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
       
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "fullImageCellID", for: indexPath) as!FullImageCell
            
            cell.fullImageView?.kf.setImage(with: URL(string: (self.detailMovieObject?.poster)!))
            cell.smallImageView.kf.setImage(with: URL(string: (self.detailMovieObject?.poster)!))
            
            if let votes = self.detailMovieObject?.imdbVotes {
                cell.leftText.text = "\(votes) imdb votes"
            }
            
            if let runTime = self.detailMovieObject?.runtime {
                cell.rightText.text = "\(runTime)utes"
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCellID", for: indexPath) as! TitleCell
            
            cell.title.text = self.detailMovieObject?.title
            
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "plotCellID", for: indexPath) as! PlotCell
            
            cell.textView.text = self.detailMovieObject?.plot
            
            return cell
            

            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCellID", for: indexPath) as! InfoCell
            
            if let items = detailMovieObject?.dictionaryRepresentation().allKeys {
                cell.titleInfo.text = "\(items[indexPath.row])"
            }

            
            if let values = detailMovieObject?.dictionaryRepresentation().allValues {
                cell.titleValue.text = "\(values[indexPath.row])"
            }
            
            return cell
        }
    }
}
