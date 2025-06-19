//
//  EpisodeTableViewCell.swift
//  ShowsSearch
//
//  Created by Marco Tullio Braga Filho on 18/06/25.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    weak var episodeNameLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        createEpisodeNameLabel()
    }
    
    func createEpisodeNameLabel() {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.textAlignment = .left
        
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        
        contentView.addSubview(label)
        episodeNameLabel = label
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15).isActive = true
        label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15).isActive = true
        
        label.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
    }
    
}
