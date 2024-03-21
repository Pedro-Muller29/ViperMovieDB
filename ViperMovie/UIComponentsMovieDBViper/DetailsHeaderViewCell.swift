//
//  DetailsHeaderViewCell.swift
//  ViperMovie
//
//  Created by Gabriel Medeiros Martins on 20/03/24.
//

import Foundation
import UIKit

class DetailsHeaderViewCell: UITableViewCell {
    static var identifier: String = "Header"
    
    var entity: Entity
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFit
        if let data = self.entity.image {
            view.image = UIImage(data: data)
        } else {
            view.image = UIImage(systemName: "questionmark")
            view.tintColor = .label
        }
        
        return view
    }()
    
    private lazy var title: UILabel = {
        let view = UILabel()
        
        view.text = self.entity.name
        view.textColor = .label
        view.textAlignment = .left
        view.font = .systemFont(ofSize: 18, weight: .bold)
        
        return view
    }()
    
    private lazy var genres: UILabel = {
        let view = UILabel()
        
        view.text = self.entity.genres
        view.textAlignment = .left
        view.textColor = .secondaryLabel
        view.font = .systemFont(ofSize: 16, weight: .light)
        
        return view
    }()
    
    private lazy var rating: UILabel = {
        let view = UILabel()
        
        view.text = "\(self.entity.rating)"
        view.textColor = .secondaryLabel
        view.textAlignment = .left
        view.font = .systemFont(ofSize: 14, weight: .light)
        
        return view
    }()
    
    private let star: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "star"))
        view.contentMode = .scaleAspectFit
        view.tintColor = .secondaryLabel
        
        return view
    }()
    
    init(entity: Entity, style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.entity = entity
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        updateData()
    }
    
    func updateData() {
        rating.text = String(format: "%.1f", entity.rating)
        genres.text = entity.genres
        title.text = entity.name
        if let data = entity.image {
            image.image = UIImage(data: data)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(image)
        
        let hstack = UIStackView()
        hstack.axis = .horizontal
        hstack.distribution = .equalSpacing
        hstack.alignment = .center
        hstack.spacing = 8
        
        hstack.addArrangedSubview(star)
        hstack.addArrangedSubview(rating)
        
        let vstack = UIStackView()
        vstack.addArrangedSubview(title)
        vstack.addArrangedSubview(genres)
        vstack.addArrangedSubview(hstack)
        
        self.contentView.addSubview(vstack)
        
        vstack.translatesAutoresizingMaskIntoConstraints = false
        hstack.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        genres.translatesAutoresizingMaskIntoConstraints = false
        star.translatesAutoresizingMaskIntoConstraints = false
        rating.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            image.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            
            vstack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            vstack.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            vstack.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
}
