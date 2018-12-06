//
//  Codable.swift
//  Frequncy
//
//  Created by chen liang on 2018/12/3.
//  Copyright © 2018 chen liang. All rights reserved.
//

import Foundation

struct Cat: Codable {
    let name: String
    let age: Int
}

let kitten = Cat(name: "kitten", age: 2)
let encoder = JSONEncoder()

func test() -> Void {
    do {
        let data = try encoder.encode(kitten)
        let _ = try JSONSerialization.jsonObject(with: data, options: [])
    } catch  {
        print("errpr")
    }
}

protocol DictionaryValue {
    var value: Any {get}
}

extension Int: DictionaryValue {var value: Any {return self}}
extension Float: DictionaryValue { var value: Any {return self}}
extension String: DictionaryValue {var value: Any {return self}}
extension Bool: DictionaryValue {var value: Any {return self}}
extension Array: DictionaryValue where Element: DictionaryValue {
    var value: Any {return map {$0.value}}
}

extension Dictionary: DictionaryValue where Value: DictionaryValue {
    var value: Any {return mapValues {$0.value}}
}

extension DictionaryValue {
    var value: Any {
        let mirror = Mirror(reflecting: self)
        var result = [String: Any]()
        for child in mirror.children {
            guard let key = child.label else {
                fatalError("Invalid key in child:\(child)")
            }
            if let value = child.value as? DictionaryValue {
                result[key] = value
            } else {
                fatalError("Invalid value in child:\(child)")
            }
            
        }
        return result
    }
}

func mirror() {
    let kitten = Cat(name: "kitten", age: 2)
    let mirror = Mirror(reflecting: kitten)
    for child in mirror.children {
        print("\(child.label!) - \(child.value)")
    }
}




