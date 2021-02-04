//
//  SalesBook_AppTests.swift
//  SalesBook_AppTests
//
//  Created by Jan Krzempek on 04/02/2021.
//

import XCTest
@testable import SalesBook_App


class SalesBook_AppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
//detailView
    func testViewModelDetail() {
        let currencyObject = CurrencyDataModelDetailed(data: "12.02.2020", value: "32.345")
        let detailedViewModel = DetailedViewModel(currency: currencyObject)
        // chech the equality between the model and ViewModel
        XCTAssertEqual(currencyObject.data, detailedViewModel.name)
        XCTAssertEqual(currencyObject.value, detailedViewModel.value)
    }
 //mainView
    func testViewModelMain() {
        let currencyObject = CurrencyDataModel(name: "EUR", value: "32.2345", imageURL: "image.jpg")
        let detailedViewModel = MainViewModel(currency: currencyObject)
        // chech the equality between the model and ViewModel
        XCTAssertEqual(currencyObject.name, detailedViewModel.name)
        XCTAssertEqual(currencyObject.imageURL, detailedViewModel.imagePath)
    }
}
