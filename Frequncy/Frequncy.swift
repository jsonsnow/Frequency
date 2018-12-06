//
//  Frequncy.swift
//  tqb_iPhone
//
//  Created by chen liang on 2018/11/30.
//  Copyright © 2018 TanQian8. All rights reserved.
//

import Foundation

public class Frequncy: NSObject, FrequncyAble, FrequncySaveAble  {
    
    //MARK: - FrequncyAble
    public var type: FrequncyType = .interval(24 * 60 * 60)
    
    public var frequncy: Int32 = 0
    
    public var curFrequncy: Int32 = 0
    
    public var saveTime: Double = 0.0
    
    public var queryNexttime: TQNextTimeQueryHandler?
    
    
    //MARK: - FrequncySaveAble
    public var saveKey: String = ""
    
    public init(frequcyDict: [String: Any]) {
        super.init()
        synchData(frequcyDict: frequcyDict)
    }
    
    public override init() {
        super.init()
    }
    
}


