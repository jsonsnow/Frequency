//
//  TQFrequencyTool.swift
//  tqb_iPhone
//
//  Created by chen liang on 2018/11/29.
//  Copyright © 2018 TanQian8. All rights reserved.
//

import Foundation

let userDefault = UserDefaults.standard


public class TQFrequencyTool: NSObject {
    
    public typealias TQNextTimeQueryHandler = () -> Double
    
//    static public func handlerFrequency(_ frequency:Int32, interval: TimeInterval, saveKey: String) -> Void {
//        let frequncy: Frequncy? = getCustomerObject(Frequncy.self, key: saveKey)
//        if  let _frequncy = frequncy {
//            _frequncy.interval = interval
//            _frequncy.frequncy = frequency
//            _frequncy.handlerActionWithIntervalType()
//            saveCustomer(object: _frequncy, key: saveKey)
//
//        } else {
//            let curFre = Frequncy(fre: frequency, cur: 1, inter: interval, save: Date.init().timeIntervalSince1970, next: 0)
//            saveCustomer(object: curFre, key: saveKey)
//        }
//    }
//
//    static public func queryFrequencyStatus(saveKey: String) -> Bool {
//        let frequncy: Frequncy? = getCustomerObject(Frequncy.self, key: saveKey)
//        if  let _frequncy = frequncy {
//            let res = _frequncy.canShowWithIntervalType()
//            return res
//
//        } else {
//            return true
//        }
//    }
//
//    static public func handlerFrequencyWithNextimeType(_ frequency:Int32, saveKey: String, query: TQNextTimeQueryHandler) -> Void {
//        let frequncy: Frequncy? = getCustomerObject(Frequncy.self, key: saveKey)
//        if  let _frequncy = frequncy {
//            _frequncy.frequncy = frequency
//            _frequncy.handlerActionWithNextTimeType(query: query)
//            saveCustomer(object: _frequncy, key: saveKey)
//
//        } else {
//            let curFre = Frequncy(fre: frequency, cur: 1, inter: 0, save: Date.init().timeIntervalSince1970, next: query())
//            saveCustomer(object: curFre, key: saveKey)
//        }
//    }
//
//    static public func queryFrequencyStatusWithNexttimeType(saveKey: String) -> Bool {
//        let frequncy = getCustomerObject(Frequncy.self, key: saveKey)
//        if  let _frequncy = frequncy {
//            let res = _frequncy.canShowWithNextTimeType()
//            return res
//
//        } else {
//            return true
//        }
//    }
    
    static public func queryFrequencyStatus<Object>(frequcy: Object) -> Bool where Object: FrequncySaveAble, Object: FrequncyAble {
        let frequncy: Frequncy = getCustomerObject(Frequncy.self, key: "saveKey")
            if  let _frequncy = frequncy {
                let res = _frequncy.canShowWithNextTimeType()
                return res
            } else {
                    return true
            }
    }
    
}

extension TQFrequencyTool {
    
    @objc static public func handlerDayFrequency(_ frequency: Int32) -> Void {
        handlerFrequency(2, interval: 24 * 60 * 60, saveKey: "day_frequency")
    }
    
    @objc static public func queryDayFrequencyStatus() -> Bool {
        return queryFrequencyStatus(saveKey: "day_frequency")
    }
    
    @objc static public func handNextDayFrequency(_ frequency: Int32) -> Void {
        handlerFrequencyWithNextimeType(2, saveKey: "next_day_frequency") {
            let date = Date.init()
            let next = date.nextDayDate()
            return next.timeIntervalSince1970
        }
    }
    
    @objc static public func queryNextTypeDayFrequency() -> Bool {
        return queryFrequencyStatusWithNexttimeType(saveKey: "next_day_frequency")
    }
}

fileprivate func saveCustomer<T: NSCoding>(object: T, key: String) -> Void {
    do {
        let data :Data!
        if #available(iOS 11, *) {
            data =  try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        } else {
            data = NSKeyedArchiver.archivedData(withRootObject: object)
        }
        userDefault.set(data, forKey: key)
        userDefault.synchronize()
    } catch let error {
        print("error:\(error)")
    }
}

fileprivate func getCustomerObject<T>(_ objectName: T.Type, key: String) -> T? where T: NSObject, T: NSCoding {
    let data = userDefault.data(forKey: key)
    if let _data = data {
        let object: NSObject?
        if #available(iOS 11, *) {
            object =  try! NSKeyedUnarchiver.unarchivedObject(ofClass: objectName, from: _data)
        } else {
            object = NSKeyedUnarchiver.unarchiveObject(with: _data) as? T
        }
        return object as? T
    }
    return nil
}

extension Date {
    func currentTimeNextDay() -> Date {
        return Date.init()
    }
}




