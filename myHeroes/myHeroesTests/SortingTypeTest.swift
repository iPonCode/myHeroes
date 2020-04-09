//  SortingTypeTest.swift
//  myHeroesTests
//
//  Created by Simón Aparicio on 08/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import XCTest
@testable import myHeroes

class SortingTypeTest: XCTestCase {

    func test_Init() {
        
        // Given
        let input = 0
        
        // When
        let result = SortingType(type: input)
        
        // Then
        XCTAssertEqual(result, SortingType.byName)
    }
    
    func test_AllCases() {

        // Then
        XCTAssertEqual(SortingType(type: 0), SortingType.byName)
        XCTAssertEqual(SortingType(type: 1), SortingType.byId)
        XCTAssertEqual(SortingType(type: 2), SortingType.byAvailableComics)
        XCTAssertEqual(SortingType(type: 3), SortingType.byAvailableEvents)
        XCTAssertEqual(SortingType(type: 4), SortingType.byAvailableSeries)
        XCTAssertEqual(SortingType(type: 5), SortingType.watched)
        XCTAssertEqual(SortingType(type: 6), SortingType.favourite)
        XCTAssertEqual(SortingType(type: 7), SortingType.featured)
        XCTAssertEqual(SortingType(type: 1324), SortingType.byName)

    }

    func test_description() {
        
        // Given
        let input = SortingType.byAvailableComics
        
        // When
        let result = input.description
        
        // Then
        XCTAssertEqual(result, "Comics (available)")
    }
    
}
