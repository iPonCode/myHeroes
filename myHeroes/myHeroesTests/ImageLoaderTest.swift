//  ImageLoaderTest.swift
//  myHeroesTests
//
//  Created by Simón Aparicio on 08/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import XCTest
@testable import myHeroes

class ImageLoaderTest: XCTestCase {

    private var dataManagerMock: DataManager = DataManagerMock()

    func test_getImage_withSuccess() {
        
        let expectation = XCTestExpectation(description: "test_getImage_withSuccess")
        (dataManagerMock as! DataManagerMock).expectation = expectation
        // Given
        let url = "https://ipon.es"
        
        // When
        let instance = ImageLoader(url: url, dataManager: dataManagerMock)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(instance.data, DataManagerMock.mockData)
        }
    }

}

class DataManagerMock: DataManager {
    
    var expectation: XCTestExpectation?
    static var mockData: Data {
        let string = "data"
        return string.data(using: .utf8)!
    }
    
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        completionHandler(DataManagerMock.mockData, nil, nil)
        expectation?.fulfill()
        return URLSessionDataTask()
    }

}
