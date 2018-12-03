//
//  Frequncy.swift
//  tqb_iPhone
//
//  Created by chen liang on 2018/11/30.
//  Copyright © 2018 TanQian8. All rights reserved.
//

import Foundation
//public class Frequncy:NSObject, NSCoding {
//    var frequncy: Int32 = 0
//    var curFrequncy: Int32 = 0
//    //第一次保存的时间
//    var saveTime: Double = 0
//
//    //频率间隔，该属性与nextTime互斥
//    var interval: Double = 0
//
//    //下一次显示时间
//    var nextTime: Double = 0
//
//
//    init(fre: Int32, cur:Int32, inter: Double, save: Double, next: Double) {
//        frequncy = fre
//        curFrequncy = cur
//        interval = inter
//        saveTime = save
//        nextTime = next
//        super.init()
//    }
//
//    public func encode(with aCoder: NSCoder) {
//        aCoder.encode(frequncy, forKey: "frequncy")
//        aCoder.encode(interval, forKey: "interval")
//        aCoder.encode(curFrequncy, forKey: "curFrequncy")
//        aCoder.encode(saveTime, forKey: "saveTime")
//        aCoder.encode(nextTime, forKey: "nextTime")
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        frequncy = aDecoder.decodeInt32(forKey: "frequncy")
//        interval = aDecoder.decodeDouble(forKey: "interval")
//        curFrequncy = aDecoder.decodeInt32(forKey: "curFrequncy")
//        saveTime = aDecoder.decodeDouble(forKey: "saveTime")
//        nextTime = aDecoder.decodeDouble(forKey: "nextTime")
//    }
//
//    func canShowWithIntervalType() -> Bool {
//        if curFrequncy < frequncy {
//            return true
//        } else {
//            let cur = Date.init().timeIntervalSince1970
//            if (cur - saveTime) > interval {
//                curFrequncy = 0
//                return true
//            }
//        }
//        return false
//    }
//
//    func handlerActionWithIntervalType() -> Void {
//        curFrequncy += 1
//        let cur = Date.init().timeIntervalSince1970
//        if (cur - saveTime) > interval {
//            curFrequncy = 1
//            saveTime = cur
//        }
//    }
//
//    func canShowWithNextTimeType() -> Bool {
//        if curFrequncy < frequncy {
//            return true
//        } else {
//            let cur = Date.init().timeIntervalSince1970
//            if cur > nextTime {
//                curFrequncy = 0
//                return true
//            }
//        }
//        return false
//    }
//
//    func handlerActionWithNextTimeType(query: TQFrequencyTool.TQNextTimeQueryHandler) -> Void {
//        curFrequncy += 1
//      public public   let cur = Date.init().timeIntervalSince1970
//        if cur > nextTime {
//            nextTime = query()
//            curFrequncy = 1
//        }
//    }
//}

public class Frequncy: NSObject, FrequncyAble, FrequncySaveAble  {
    

    public var type: FrequncyType = .interval(24 * 60 * 60)
    
    public var frequncy: Int32 = 0
    
    public var curFrequncy: Int32 = 0
    
    public var saveTime: Double = 0.0
    
    
}


