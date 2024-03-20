//
//  ImageTitleDescriptionRatingTableViewCell.swift
//  UIComponentsMovieDBViper
//
//  Created by Pedro Mezacasa Muller on 19/03/24.
//

import UIKit

class ImageTitleDescriptionRatingTableViewCell: UITableViewCell {

    static var identifier: String = "CELL"
    
    var data: Entity?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    lazy private var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        if let data = data?.image,
           let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "questionmark")
            imageView.tintColor = .label
        }
        return imageView
    }()
    
    lazy private var title: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = data?.name
        return label
    }()
    
    lazy private var overview: UILabel = {
        let description = UILabel()
        description.textColor = .secondaryLabel
        description.textAlignment = .left
        description.font = .systemFont(ofSize: 13, weight: .regular)
        description.text = data?.overview
        description.numberOfLines = 3
        return description
    }()
    
//    lazy private var ratings: UIStackView = {
//        let ratings = UIStackView()
//        ratings.axis = .horizontal
//    }()
    
    func setupUI() {
        self.contentView.addSubview(image)
        let stack = UIStackView()
        stack.addSubview(title)
        stack.addSubview(overview)
        stack.distribution = .equalSpacing
        self.contentView.addSubview(stack)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        overview.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
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
            title.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            
            overview.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            overview.trailingAnchor.constraint(equalTo: stack.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
