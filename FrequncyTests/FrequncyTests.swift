//
//  FrequncyTests.swift
//  FrequncyTests
//
//  Created by chen liang on 2018/12/3.
//  Copyright © 2018 chen liang. All rights reserved.
//

import XCTest
@testable import Frequncy

class FrequncyTests: XCTestCase {

    override func setUp() {
       
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        userDefault.removeObject(forKey: "test1")
        assert(FrequencyScheduler.queryNextDayStatus(3, saveKey: "test1"))
        FrequencyScheduler.handlerDayFrequency(saveKey: "test1")
        assert(FrequencyScheduler.queryNextDayStatus(3, saveKey: "test1"))
        FrequencyScheduler.handlerDayFrequency(saveKey: "test1")
        assert(FrequencyScheduler.queryNextDayStatus(3, saveKey: "test1"))
        FrequencyScheduler.handlerDayFrequency(saveKey: "test1")
       
    }
    
    func testnextDay1() -> Void {
        assert(FrequencyScheduler.queryNextDayStatus(3, saveKey: "test1"))
        FrequencyScheduler.handlerDayFrequency(saveKey: "test1")
    }
    
    func testDayInterval() {
        userDefault.removeObject(forKey: "test2")
        assert(FrequencyScheduler.queryOneDayIntervalStatus(3, saveKey: "test2"))
        FrequencyScheduler.handlerDayFrequency(saveKey: "test2")
        assert(FrequencyScheduler.queryOneDayIntervalStatus(3, saveKey: "test2"))
        FrequencyScheduler.handlerDayFrequency(saveKey: "test2")
        assert(FrequencyScheduler.queryOneDayIntervalStatus(3, saveKey: "test2"))
        FrequencyScheduler.handlerDayFrequency(saveKey: "test2")
    }
    
    func testDayInterval1() -> Void {
        assert(FrequencyScheduler.queryOneDayIntervalStatus(3, saveKey: "test2"))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
