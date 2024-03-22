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
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
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
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.numberOfLines = 2
        
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
//        genres.text = entity.genres
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
        hstack.alignment = .center
        hstack.spacing = 8
        
        let spacer = UIView()
        // maximum width constraint
        let spacerWidthConstraint = spacer.widthAnchor.constraint(equalToConstant: .greatestFiniteMagnitude) // or some very high constant
        spacerWidthConstraint.priority = .defaultLow // ensures it will not "overgrow"
        spacerWidthConstraint.isActive = true
        
        hstack.addArrangedSubview(star)
        hstack.addArrangedSubview(rating)
        hstack.addArrangedSubview(spacer)
        
        
        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.addArrangedSubview(title)
        vstack.addArrangedSubview(genres)
        vstack.addArrangedSubview(hstack)
        vstack.spacing = 8
        
        self.contentView.addSubview(vstack)
        
        vstack.translatesAutoresizingMaskIntoConstraints = false
//        hstack.translatesAutoresizingMaskIntoConstraints = false
//        title.translatesAutoresizingMaskIntoConstraints = false
//        genres.translatesAutoresizingMaskIntoConstraints = false
//        star.translatesAutoresizingMaskIntoConstraints = false
//        rating.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            image.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 128),
            image.heightAnchor.constraint(equalToConstant: 194),
            
            vstack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            vstack.bottomAnchor.constraint(equalTo: self.image.bottomAnchor, constant: -8),
            vstack.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            vstack.topAnchor.constraint(equalTo: image.centerYAnchor, constant: -32)
        ])
    }
}
