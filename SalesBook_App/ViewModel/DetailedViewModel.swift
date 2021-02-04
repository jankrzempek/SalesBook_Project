//
//  DetailedViewModel.swift
//  SalesBook_App
//
//  Created by Jan Krzempek on 03/02/2021.
//

import Foundation

struct DetailedViewModel {
    
    var name: String
    var value: String
    
    init(currency: CurrencyDataModelDetailed) {
        self.name = currency.data
        self.value = currency.value
    }
}
