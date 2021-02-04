//
//  CoreFile.swift
//  SalesBook_App
//
//  Created by Jan Krzempek on 03/02/2021.
//

import Foundation

//Menages states - if it is Your first time?
class Core {
    static let shared = Core()
    
    func isNewUser() -> Bool{

        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
