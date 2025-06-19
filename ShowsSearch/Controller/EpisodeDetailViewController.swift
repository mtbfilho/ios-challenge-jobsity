//
//  EpisodeDetailViewController.swift
//  ShowsSearch
//
//  Created by Marco Tullio Braga Filho on 18/06/25.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    weak var mainStackView: UIStackView?
    
    weak var episodeImageView: UIImageView?
    weak var episodeNameLabel: UILabel?
    
    weak var episodeSummaryTextView: UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()

        createMainStackView()
        
        createEpisodeImageView()
        createEpisodeNameLabel()
        createEpisodeSummaryTextView()
        
        addSpacer()
        
        navigationItem.title = "Episode's Detail"
    }
    
    func createMainStackView() {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        stackView.alignment = .center
        stackView.spacing = 10
        
        view.addSubview(stackView)
        mainStackView = stackView
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        stackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15).isActive = true
    }
    
    func createEpisodeImageView() {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: URL(string: selectedEpisode!.image.medium))
        
        mainStackView?.addArrangedSubview(imageView)
        episodeImageView = imageView
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func createEpisodeNameLabel() {
        let label = UILabel()
        
        label.numberOfLines = 2
        label.textAlignment = .left
        
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 26)
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        
        label.text = "Name: \(selectedEpisode!.name), Number: \(selectedEpisode!.number), Season: \(selectedEpisode!.season)"
        
        mainStackView?.addArrangedSubview(label)
        episodeNameLabel = label
        
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createEpisodeSummaryTextView() {
        let textView = UITextView()
        
        textView.isEditable = false
        
        if let htmlData = selectedEpisode!.summary.data(using: .utf8) {
            let options = [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html
            ]
            
            let attributedString = try? NSMutableAttributedString(data: htmlData, options: options, documentAttributes: nil)
            attributedString?.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: attributedString?.length ?? 0))
            
            textView.attributedText = attributedString
        }
        
        mainStackView?.addArrangedSubview(textView)
        episodeSummaryTextView = textView
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        textView.leadingAnchor.constraint(equalTo: mainStackView!.leadingAnchor, constant: 5).isActive = true
        textView.trailingAnchor.constraint(equalTo: mainStackView!.trailingAnchor, constant: -5).isActive = true
    }
    
    func addSpacer() {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        
        mainStackView?.addArrangedSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }

}
