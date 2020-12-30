//
//  ListMovieCell.swift
//  MovieVIP
//
//  Created by Tifo Audi Alif Putra on 12/12/20.
//

import UIKit
import Kingfisher

class ListMovieCell: UITableViewCell {

    static let cellIdentifier = "listMovieCellIdentifier"
    
    let container = UIView()
    let movieImageView = UIImageView()
    let titleLabel = UILabel()
    let overviewLabel = UILabel()
    
    var movie: Movie? {
        didSet {
            self.configureCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ListMovieCell {
    func configureCell() {
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        contentView.addSubview(movieImageView)
        
        if let movieUrl = movie?.posterURL {
            movieImageView.kf.setImage(with: movieUrl)
            container.addSubview(movieImageView)
        }
        
        movieImageView.clipsToBounds = true
        movieImageView.layer.cornerRadius = 4
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = movie?.title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        
        overviewLabel.text = movie?.overview
        overviewLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        overviewLabel.adjustsFontForContentSizeCategory = true
        overviewLabel.numberOfLines = 5
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        overviewLabel.text = movie?.overview
        overviewLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        overviewLabel.adjustsFontForContentSizeCategory = true
        overviewLabel.numberOfLines = 5
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let movieLabelStackView = UIStackView(arrangedSubviews: [titleLabel, overviewLabel])
        movieLabelStackView.axis = .vertical
        movieLabelStackView.alignment = .leading
        movieLabelStackView.spacing = 8
        movieLabelStackView.distribution = .equalSpacing
        movieLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(movieLabelStackView)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            movieImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            movieImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            movieImageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            movieImageView.widthAnchor.constraint(equalToConstant: 120),
            
            movieLabelStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            movieLabelStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            movieLabelStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
        ])
    }
}
