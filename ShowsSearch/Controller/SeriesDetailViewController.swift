//
//  SeriesDetailViewController.swift
//  ShowsSearch
//
//  Created by Marco Tullio Braga Filho on 17/06/25.
//

import UIKit
import SDWebImage

class SeriesDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var mainStackView: UIStackView?
    weak var tableView: UITableView?
    
    weak var seriesImageView: UIImageView?
    weak var seriesNameLabel: UILabel?
    
    weak var seriesSummaryTextView: UITextView?
    
    weak var horizontalStackView: UIStackView?
    weak var leftVerticalStackView: UIStackView?
    weak var rightVerticalStackView: UIStackView?
    
    weak var seriesTimeAndDaysLabel: UILabel?
    weak var seriesGenresLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        createMainStackView()
        createTableView()
        
        createHorizontalStackView()
        createLeftVerticalStackView()
        createRightVerticalStackView()
        
        createSeriesImageView()
        createSeriesNameLabel()
        
        createSeriesTimeAndDaysLabel()
        createSeriesGenresLabel()
        
        createSeriesSummaryTextView()
        
        navigationItem.title = "Series' Detail"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchEpisodes(selectedSeries!.show.id) { [weak self] in
            self?.tableView?.reloadData()
        }
    }
    
    func createMainStackView() {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        stackView.alignment = .center
        stackView.spacing = 10
        
        view.addSubview(stackView)
        mainStackView = stackView
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        stackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15).isActive = true
    }
    
    func createTableView() {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")
        
        view.addSubview(tableView)
        self.tableView = tableView
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.topAnchor.constraint(equalTo: mainStackView!.bottomAnchor,constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    func createSeriesImageView() {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: URL(string: selectedSeries!.show.image.medium))
        
        leftVerticalStackView?.addArrangedSubview(imageView)
        seriesImageView = imageView
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func createSeriesNameLabel() {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.textAlignment = .left
        
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 36)
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        
        label.text = selectedSeries?.show.name
        
        leftVerticalStackView?.addArrangedSubview(label)
        seriesNameLabel = label
        
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createSeriesSummaryTextView() {
        let textView = UITextView()
        
        textView.isEditable = false
        
        if let htmlData = selectedSeries!.show.summary.data(using: .utf8) {
            let options = [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html
            ]
            
            let attributedString = try? NSMutableAttributedString(data: htmlData, options: options, documentAttributes: nil)
            attributedString?.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: attributedString?.length ?? 0))
            
            textView.attributedText = attributedString
        }
        
        mainStackView?.addArrangedSubview(textView)
        seriesSummaryTextView = textView
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        textView.leadingAnchor.constraint(equalTo: mainStackView!.leadingAnchor, constant: 5).isActive = true
        textView.trailingAnchor.constraint(equalTo: mainStackView!.trailingAnchor, constant: -5).isActive = true
    }
    
    func createHorizontalStackView() {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        stackView.alignment = .top
        stackView.spacing = 5
        
        mainStackView?.addArrangedSubview(stackView)
        horizontalStackView = stackView
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createLeftVerticalStackView() {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        stackView.alignment = .center
        stackView.spacing = 10
        
        horizontalStackView?.addArrangedSubview(stackView)
        leftVerticalStackView = stackView
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createRightVerticalStackView() {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        stackView.alignment = .leading
        stackView.spacing = 10
        
        horizontalStackView?.addArrangedSubview(stackView)
        rightVerticalStackView = stackView
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createSeriesTimeAndDaysLabel() {
        let label = UILabel()
        
        label.numberOfLines = 5
        label.textAlignment = .left
        
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 24)
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        
        label.lineBreakMode = .byTruncatingTail
        
        let time = selectedSeries?.show.schedule.time ?? ""
        let days = selectedSeries?.show.schedule.days.joined(separator: ", ") ?? ""
        
        label.text = "Time: \(time), Days: \(days)"
        
        rightVerticalStackView?.addArrangedSubview(label)
        seriesTimeAndDaysLabel = label
        
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createSeriesGenresLabel() {
        let label = UILabel()
        
        label.numberOfLines = 5
        label.textAlignment = .left
        
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        
        label.lineBreakMode = .byTruncatingTail
        
        let genres = selectedSeries?.show.genres.joined(separator: ", ") ?? ""
        label.text = "Genres: \(genres)"
        
        rightVerticalStackView?.addArrangedSubview(label)
        seriesGenresLabel = label
        
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allEpisodes.reduce(into: Array<Int>()) {
            if !$0.contains($1.rowSection) { $0.append($1.rowSection) }
        }.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEpisodes.reduce(0) { $0 + ($1.rowSection == section ? 1 : 0) }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as! EpisodeTableViewCell
        let item = allEpisodes[indexPath.section, indexPath.row]
        
        cell.episodeNameLabel!.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season: \(allEpisodes[section, 0].season)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowEpisodeDetailSegue", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else {
            return
        }
        
        selectedEpisode = allEpisodes[indexPath.section, indexPath.row]
    }

}
