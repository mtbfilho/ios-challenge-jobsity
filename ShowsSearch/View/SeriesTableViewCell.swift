//
//  SeriesTableViewCell.swift
//  ShowsSearch
//
//  Created by Marco Tullio Braga Filho on 17/06/25.
//

import UIKit

class SeriesTableViewCell: UITableViewCell {
    
    weak var seriesNameLabel: UILabel?
    weak var seriesImageView: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        createSeriesImageView()
        createSeriesNameLabel()
    }

    func createSeriesNameLabel() {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.textAlignment = .left
        
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        
        contentView.addSubview(label)
        seriesNameLabel = label
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        label.leadingAnchor.constraint(equalTo: seriesImageView!.trailingAnchor, constant: 15).isActive = true
        label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15).isActive = true
        
        label.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
    }
    
    func createSeriesImageView() {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(imageView)
        seriesImageView = imageView
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15).isActive = true
        
        imageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
    }
    
}
