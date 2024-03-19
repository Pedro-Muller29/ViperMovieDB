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
        description.textColor = .label
        description.textAlignment = .left
        description.font = .systemFont(ofSize: 13, weight: .regular)
        description.text = "Overview"
        return description
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    func setupUI() {
        self.contentView.addSubview(image)
        let stack = UIStackView()
        stack.addSubview(title)
        stack.addSubview(overview)
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
            
            stack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            stack.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            
            title.leadingAnchor.constraint(equalTo: stack.trailingAnchor,constant: 16),
            title.topAnchor.constraint(equalTo: stack.topAnchor, constant: 16),
            
            overview.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            overview.leadingAnchor.constraint(equalTo: stack.trailingAnchor,constant: 16),
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
