//
//  RetryTests.swift
//  TaskQueue iOSTests
//
//  Created by BENSALA on 20/03/2019.
//

import XCTest
@testable import TaskQueue

enum RetryError: Error {
    case empty
}

class RetryTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRetry() {
        let testable = self.expectation(description: "Test retry")
        var i = 0
        retry {
            i += 1
            throw RetryError.empty
        }.finalDefer {
            XCTAssertEqual(i, 3)
            testable.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testAsyncRetry() {
        let testable = self.expectation(description: "Test retry async")
        var i = 0
        retryAsync {
            i += 1
            throw RetryError.empty
        }.finalDefer {
            XCTAssertEqual(i, 3)
            testable.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testAsyncRetryWithDelay() {
        let testable = self.expectation(description: "Test retry async with delay")
        var i = 0
        retryAsync(max: 3, retryStrategy: .delay(seconds: 2.0)){
            i += 1
            throw RetryError.empty
        }.finalDefer {
                XCTAssertEqual(i, 3)
                testable.fulfill()
        }
        
        waitForExpectations(timeout: 6.0, handler: nil)
    }
}
