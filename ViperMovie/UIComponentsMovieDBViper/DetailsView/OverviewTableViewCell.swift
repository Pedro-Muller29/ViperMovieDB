//
//  OverviewTableViewCell.swift
//  ViperMovie
//
//  Created by Pedro Mezacasa Muller on 22/03/24.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    static var identifier: String = "Overview"
    var entity: Entity
    
    private lazy var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "Overview"
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private lazy var textBody: UILabel = {
        let textBody = UILabel()
        textBody.text = entity.overview
        textBody.textColor = .secondaryLabel
        textBody.font = .systemFont(ofSize: 14, weight: .regular)
        textBody.numberOfLines = 0
        return textBody
    }()
    
    init(entity: Entity, style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.entity = entity
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textBody)
        textBody.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            textBody.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textBody.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            textBody.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }

}
