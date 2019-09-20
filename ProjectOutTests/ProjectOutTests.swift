//
//  ProjectOutTests.swift
//  ProjectOutTests
//
//  Created by Consultant on 9/11/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import XCTest
@testable import ProjectOut

class ProjectOutTests: XCTestCase, ImageViewModelDelegate{
    var imageViewModel: ImageViewModel!
    
    func updateView() {
        fatalError()
    }
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCanParseJSON() {
        
        // parse some JSON
        // ensure we always have 50-images
    }

    func testCanReceiveRemoteData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        imageViewModel = ImageViewModel(ImageService())
        var photos = [Image]()
        let promise = expectation(description: "Download JSON")
        imageViewModel.imageService.getImage{ pho in
            photos = pho
            promise.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(!photos.isEmpty)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
