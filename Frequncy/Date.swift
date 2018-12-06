//
//  File.swift
//  Frequncy
//
//  Created by chen liang on 2018/12/3.
//  Copyright © 2018 chen liang. All rights reserved.
//

import Foundation

let _calendar = Calendar.current

extension Date {
    
    /// get current date's next day date
    ///
    /// - Returns: next day date
    public func nextDayDate() -> Date {
        var nextDay = self.addingTimeInterval(24 * 60 * 60)
        var components = dateComponents(nextDay)
        components.hour = 0
        components.minute = 0
        components.second = 0
        nextDay = _calendar.date(from: components)!
        return nextDay
    }
    
    /// date day
    ///
    /// - Returns: day
    public func dateDay() -> Int? {
        let components = dateComponents(self)
        return components.day
    }
    
    
    /// date month
    ///
    /// - Returns: month
    public func dateMonth() -> Int? {
        let components = dateComponents(self)
        return components.month
    }
    
    
    /// date year
    ///
    /// - Returns: year
    public func dateYear() -> Int? {
        let components = dateComponents(self)
        return components.year
    }
    
    
    /// pre month date
    ///
    /// - Parameter day: pre spec day
    /// - Returns: pre month date
    public func previousMothDate(_ day:Int) -> Date {
        var _day = day
        if day <= 0 || day > 31 {
            _day = 15
        }
        var components = dateComponents(self)
        components.day = _day
        if components.month == 1 {
            components.month = 12
            components.year  = components.year! - 1
        } else {
            components.month = components.month! - 1
        }
        let pre = _calendar.date(from: components)!
        return pre
    }
    
    /// next month date
    ///
    /// - Parameter day: next spec day
    /// - Returns: next month date
    public func nextMonthDate(_ day: Int) -> Date {
        var _day = day
        if day <= 0 || day > 31 {
            _day = 15
        }
        var components = dateComponents(self)
        components.day = _day
        if components.month == 12 {
            components.month = 1
            components.year  = components.year! + 1
        } else {
            components.month = components.month! + 1
        }
        let next = _calendar.date(from: components)!
        return next
    }
    
    /// total day in current month
    ///
    /// - Returns: total
    public func totalDaysInMonth() -> Int {
        let totalDays = _calendar.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self)?.count
        return totalDays!
    }
    
    public func firstWeekDayInMonth() -> Int {
        var components = dateComponents(self)
        components.day = 1
        let firstDate = _calendar.date(from: components)!
        let firstWeekDay = _calendar.ordinality(of: Calendar.Component.weekday, in: Calendar.Component.weekOfMonth, for: firstDate)
        return firstWeekDay!
    }
    
    public func isSameMonth(date: Date) -> Bool {
        var result = false
        let curComponents = dateComponents(self)
        let specifComponents = dateComponents(date)
        if curComponents.year == specifComponents.year && curComponents.month == specifComponents.month {
            result = true
        }
        return result
    }
    
    public func dateComponents(_ date: Date) -> DateComponents {
       return _calendar.dateComponents(Set.init([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day]), from: date)
    }
}
