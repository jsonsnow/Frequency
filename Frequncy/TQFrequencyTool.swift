//
//  TQFrequencyTool.swift
//  tqb_iPhone
//
//  Created by chen liang on 2018/11/29.
//  Copyright © 2018 TanQian8. All rights reserved.
//

import Foundation

let userDefault = UserDefaults.standard
public typealias TQNextTimeQueryHandler = () -> Double

public class TQFrequencyTool: NSObject {

    static public var frequencyDatas = [String: Frequncy]()
    static public func queryFrequencyStatus<Object>(frequcy: Object) -> Bool where Object: FrequncySaveAble, Object: FrequncyAble {
        let saveData = userDefault.dictionary(forKey: frequcy.saveKey)
        guard let data = saveData else { return true }
        frequcy.synchData(frequcyDict: data)
        return frequcy.canShow()
    }
    
    static public func handlerFrequencyStatus<Object>(frequcy: Object) where Object: FrequncySaveAble, Object: FrequncyAble {
       frequcy.handlePlusCurFrequncyEvent(query: nil)
        userDefault.set(frequcy.value, forKey: frequcy.saveKey)
    }
    
}

extension TQFrequencyTool {
    
    @objc static public func handlerDayFrequency(_ frequency: Int32, saveKey: String) -> Void {
        if let model = TQFrequencyTool.frequencyDatas[saveKey] {
            handlerFrequencyStatus(frequcy: model)
        } else {
            let model = Frequncy.dayFrequency(fre: frequency, type: .interval(24 * 60 * 60), saveKey: saveKey) {
                let date = Date.init()
                return date.nextDayDate().timeIntervalSince1970
            }
            TQFrequencyTool.frequencyDatas[saveKey] = model
        }
    }

//    @objc static public func queryStatus(saveKey: String) -> Bool {
//        
//    }

    @objc static public func handNextDayFrequency(_ frequency: Int32, saveKey: String) -> Void {
        handlerFrequencyStatus(frequcy: Frequncy.dayFrequency(fre: frequency, type: .nextTime(24 * 60 * 60), saveKey: saveKey,query: { () -> Double in
            let date = Date.init()
            return date.nextDayDate().timeIntervalSince1970
        }))
    }
}

extension Frequncy {
    class func dayFrequency(fre: Int32, type: FrequncyType, saveKey: String, query: @escaping TQNextTimeQueryHandler) -> Frequncy {
        let frequency = Frequncy.init()
        frequency.frequncy = fre
        frequency.type = type
        frequency.saveKey = saveKey
        frequency.queryNextTime = query
        return frequency
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





