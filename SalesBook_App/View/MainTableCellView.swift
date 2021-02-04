//
//  TableViewCell.swift
//  Zadanie
//
//  Created by Jan Krzempek on 01/07/2020.
//  Copyright © 2020 Jan Krzempek. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseStorage

class TableViewCell: UITableViewCell {
    
    let storage = Storage.storage(url: "gs://salesb-8cc9f.appspot.com")
    
    var mainViewModel: MainViewModel! {
        didSet {
            guard let data = mainViewModel else { return }
            name.text = data.name
            value.text = data.value
            urlOfImageInString = data.imagePath
            // downloadi mages from Firebase
            let StorageRef = Storage.storage().reference(withPath: "Images/" + urlOfImageInString)
            
            StorageRef.downloadURL { (url, eroor) in
                if let imageUrl = url {
                    self.imagez.kf.setImage(with: imageUrl)
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var urlOfImageInString = ""
    
    let value: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        label.text = "Title"
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imagez: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "text"
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 243/255, green: 181/255, blue: 67/255, alpha: 0.8)
        view.layer.cornerRadius = 8
        return view
    }()
}

private extension TableViewCell {
    func setupSubviews() {
        
        container.addSubview(value)
        container.addSubview(name)
        container.addSubview(imagez)
        contentView.addSubview(container)
        
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        
        value.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4).isActive = true
        value.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5).isActive = true
        value.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        imagez.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5).isActive = true
        imagez.topAnchor.constraint(equalTo: container.topAnchor, constant: 15).isActive = true
        imagez.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imagez.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imagez.translatesAutoresizingMaskIntoConstraints = false
        
        name.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 40).isActive = true
        name.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4).isActive = true
        name.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
