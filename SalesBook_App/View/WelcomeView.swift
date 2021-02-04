//
//  WelcomeViewController.swift
//  SalesBook_App
//
//  Created by Jan Krzempek on 03/02/2021.
//

import UIKit

class WelcomeView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    let imagez: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "spalsh"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let navTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 20,
            weight: .bold
        )
        label.text = "Welcome in the App!"
        label.numberOfLines = 5
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let text: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 18,
            weight: .bold
        )
        label.text = "Browse currencies, \n Change the default currency, \n Get the data between today and previous monday, \n Enjoy!"
        label.numberOfLines = 5
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupUI() {
        view.addSubview(imagez)
        view.addSubview(navTitle)
        view.addSubview(text)
        
        imagez.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imagez.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        imagez.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        imagez.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imagez.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imagez.translatesAutoresizingMaskIntoConstraints = false
        
        navTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        navTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4).isActive = true
        navTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4).isActive = true
        navTitle.bottomAnchor.constraint(equalTo: imagez.topAnchor, constant: 10).isActive = true
        
        text.topAnchor.constraint(equalTo: imagez.bottomAnchor, constant: 10).isActive = true
        text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4).isActive = true
        text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4).isActive = true
        text.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
    }
}
