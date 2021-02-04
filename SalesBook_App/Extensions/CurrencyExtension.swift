//
//  CurrencyExtension.swift
//  SalesBook_App
//
//  Created by Jan Krzempek on 03/02/2021.
//

import Foundation
//extension for currency to get symbols
class Currency {
    static let shared: Currency = Currency()
    
    private var cache: [String:String] = [:]
    
    func findSymbol(currencyCode:String) -> String {
        
        if let hit = cache[currencyCode] { return hit }
        guard currencyCode.count < 4 else { return "" }
        let symbol = findSymbolBy(currencyCode)
        cache[currencyCode] = symbol
        
        return symbol
    }
    
    private func findSymbolBy(_ currencyCode: String) -> String {
        var candidates: [String] = []
        let locales = NSLocale.availableLocaleIdentifiers
        
        for localeId in locales {
            guard let symbol = findSymbolBy(localeId: localeId, currencyCode: currencyCode) else { continue }
            if symbol.count == 1 { return symbol }
            candidates.append(symbol)
        }
        return candidates.sorted(by: { $0.count < $1.count }).first ?? ""
    }
    
    private func findSymbolBy(localeId: String, currencyCode: String) -> String? {
        let locale = Locale(identifier: localeId)
        return currencyCode.caseInsensitiveCompare(locale.currencyCode ?? "") == .orderedSame ? locale.currencySymbol : nil
    }
}

extension String {
    var currencySymbol: String { return Currency.shared.findSymbol(currencyCode: self) }
}
