//
//  HistoryModel.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/19/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//


import Foundation
class HistoryModel {
   // Note that we are passing in a function to the getAllPeople method (similar to our use of callbacks in JS). This function will allow the ViewController that calls this method to dictate what runs upon completion.
   static func getAll(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
      let url = URL(string: "http://192.168.0.51:8000/history")
      
      let session = URLSession.shared
      
      let task = session.dataTask(with: url!, completionHandler: completionHandler)
      
      task.resume()
   }
   
   
}
