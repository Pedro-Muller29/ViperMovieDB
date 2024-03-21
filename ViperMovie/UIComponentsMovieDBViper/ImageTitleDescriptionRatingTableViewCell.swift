//
//  ImageTitleDescriptionRatingTableViewCell.swift
//  UIComponentsMovieDBViper
//
//  Created by Pedro Mezacasa Muller on 19/03/24.
//

import UIKit

class ImageTitleDescriptionRatingTableViewCell: UITableViewCell {

    static var identifier: String = "CELL"
    
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .label
        imageView.backgroundColor = .secondaryLabel
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Title"
        return label
    }()
    
    private let overview: UILabel = {
        let description = UILabel()
        description.textColor = .secondaryLabel
        description.textAlignment = .left
        description.font = .systemFont(ofSize: 13, weight: .regular)
        description.text = "Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview "
        description.numberOfLines = 3
        return description
    }()
    
    private let ratingsLabel: UILabel = {
        var ratingsLabel = UILabel()
        ratingsLabel.text = "0.0"
        ratingsLabel.textColor = .secondaryLabel
        ratingsLabel.numberOfLines = 1
        ratingsLabel.font = .systemFont(ofSize: 12, weight: .light)
        return ratingsLabel
    }()
    
    private let ratingsStar: UIImageView = {
        var ratingsStar = UIImageView(image: UIImage(systemName: "star"))
        ratingsStar.contentMode = .scaleAspectFit
        ratingsStar.tintColor = .secondaryLabel
        return ratingsStar
    }()
    
    func updateUI(with data: Entity) {
        if let data = data.image,
           let uiImage = UIImage(data: data) {
            image.image = uiImage
        }
        title.text = data.name
        overview.text = data.overview
        ratingsLabel.text = String(format: "%.1f", data.rating)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    func setupUI() {
        self.contentView.addSubview(image)
        let stack = UIStackView()
        stack.addSubview(title)
        stack.addSubview(overview)
        stack.addSubview(ratingsStar)
        stack.addSubview(ratingsLabel)
        self.contentView.addSubview(stack)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        overview.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsStar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            image.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: 118),
            image.widthAnchor.constraint(equalToConstant: 79),
            
            stack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            stack.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            
            title.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            title.topAnchor.constraint(equalTo: stack.topAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            
            overview.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            overview.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            overview.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            
            ratingsLabel.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: -8),
            ratingsLabel.leadingAnchor.constraint(equalTo: ratingsStar.trailingAnchor, constant: 4),
            ratingsLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            
            ratingsStar.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            ratingsStar.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: -8),
            ratingsStar.heightAnchor.constraint(equalToConstant: 13),
            ratingsStar.widthAnchor.constraint(equalToConstant: 12.92)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            super.setSelected(false, animated: animated)
        })
        // Configure the view for the selected state
    }

}
