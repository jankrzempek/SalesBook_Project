//
//  TableViewCell.swift
//  Zadanie
//
//  Created by Jan Krzempek on 01/07/2020.
//  Copyright © 2020 Jan Krzempek. All rights reserved.
//

import UIKit
class DetailedTableViewCell: UITableViewCell {
    
    var detailedViewModel: DetailedViewModel! {
        didSet {
            guard let data = detailedViewModel else { return }
            title.text = data.value
            value.text = data.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        label.text = "Title"
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let value: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "text"
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 111/255, green: 112/255, blue: 211/255, alpha: 1)
        view.layer.cornerRadius = 8
        return view
    }()
}


private extension DetailedTableViewCell {
    func setupSubviews() {
        
        container.addSubview(title)
        container.addSubview(value)
        contentView.addSubview(container)
        
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        
        title.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4).isActive = true
        title.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5).isActive = true
        title.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        value.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        value.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5).isActive = true
        value.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4).isActive = true
        value.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
}
