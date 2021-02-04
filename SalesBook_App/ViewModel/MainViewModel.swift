//
//  MainViewModel.swift
//  SalesBook_App
//
//  Created by Jan Krzempek on 03/02/2021.
//

import Foundation

struct MainViewModel {
    
    var name: String
    var value: String
    var imagePath: String
    
    init(currency: CurrencyDataModel) {
        self.name = currency.name
        self.value = currency.value
        self.imagePath = currency.imageURL
    }
}
