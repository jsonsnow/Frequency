//
//  FrequncyAble.swift
//  Frequncy
//
//  Created by chen liang on 2018/12/3.
//  Copyright © 2018 chen liang. All rights reserved.
//

import Foundation

public protocol FrequncySaveAble {
    var value: Any {get}
}

extension FrequncySaveAble where Self:FrequncyAble {
    public var value: Any {
        return ["frequncy": frequncy,
                "curFrequncy":curFrequncy,
                "saveTime":saveTime,
                "type": type.value
        ]
    }
}

public enum FrequncyType: FrequncySaveAble {
    
    case interval(Double)
    case nextTime(Double)
    
     public var value: Any {
        switch self {
        case .interval(let interval):
            return ["interval": interval]
        case .nextTime(let nextTime):
            return ["nextTime": nextTime]
        }
    }
    
}


public protocol FrequncyAble: class {
    var type: FrequncyType {set get}
    var frequncy: Int32 {set get}
    var curFrequncy: Int32 {set get}
    var saveTime: Double {set get}
    
    func nextTime() -> Double
    func canShow() -> Bool
    func handlePlusCurFrequncyEvent(query: TQFrequencyTool.TQNextTimeQueryHandler?)
}

extension FrequncyAble {
    
    public func canShow() -> Bool {
        switch type {
        case .interval(let interval):
            return canShowWithIntervalType(interval: interval)
        case .nextTime(let nextTime):
            return canShowWithNextTimeType(nextTime: nextTime)
        }
    }
    
    private func canShowWithIntervalType(interval: Double) -> Bool {
        if curFrequncy < frequncy {
            return true
        } else {
            let cur = Date.init().timeIntervalSince1970
            if (cur - saveTime) > interval {
                self.curFrequncy = 0
                return true
            }
        }
        return false
    }
    
    func canShowWithNextTimeType(nextTime: Double) -> Bool {
        if curFrequncy < frequncy {
            return true
        } else {
            let cur = Date.init().timeIntervalSince1970
            if cur > nextTime {
                curFrequncy = 0
                return true
            }
        }
        return false
    }
    
    private func handlerActionWithNextTimeType(nextTime: Double, query: TQFrequencyTool.TQNextTimeQueryHandler) -> Void {
        curFrequncy += 1
        let cur = Date.init().timeIntervalSince1970
        if cur > nextTime {
            self.type = .nextTime(query())
            curFrequncy = 1
        }
    }
    
    private func handlerActionWithIntervalType(interval: Double) -> Void {
        curFrequncy += 1
        let cur = Date.init().timeIntervalSince1970
        if (cur - saveTime) > interval {
            curFrequncy = 1
            saveTime = cur
        }
    }

    public func handlePlusCurFrequncyEvent(query: TQFrequencyTool.TQNextTimeQueryHandler?)  {
        switch type {
        case .interval(let interval):
            handlerActionWithIntervalType(interval: interval)
        case .nextTime(let nextTime):
            handlerActionWithNextTimeType(nextTime: nextTime, query: query ?? self.nextTime)
        }
    }
    
    public func nextTime() -> Double {
        assert(false, "nextTime error")
    }
}



