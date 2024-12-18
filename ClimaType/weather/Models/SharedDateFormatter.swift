//
//  SharedDateFormatter.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/18/24.
//
import Foundation

let sharedDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}() 
