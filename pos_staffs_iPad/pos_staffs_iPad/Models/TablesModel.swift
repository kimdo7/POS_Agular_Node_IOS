//
//  TablesModel.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation

class TablesModel{
   static func getAll(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
      let url = URL(string: "http://192.168.0.51:8000/tables")
      
      let session = URLSession.shared
      
      let task = session.dataTask(with: url!, completionHandler: completionHandler)
      
      task.resume()
   }
   
   static func newTable(table: Table, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
      // Create the url to request
      if let urlToReq = URL(string: "http://192.168.0.51:8000/table") {
         
         var request = URLRequest(url: urlToReq)
         
         request.httpMethod = "POST"
         
         let key = table.itemList[0]
         let size = key.split(separator: ":")[0]
         let item_id = key.split(separator: ":")[1]
         let name = table.items[key]?.name
         let quanity = table.items[key]?.quanity
         let price = table.items[key]?.price
         
         
         // prepare json data
         let json: [String: Any] = ["table_id": table.id,
                                    "order": ["name": name as Any, "item_id":item_id, "price": price as Any, "quanity": quanity as Any, "size": size]]
         
         let jsonData = try? JSONSerialization.data(withJSONObject: json)

         
         request.httpBody = jsonData
         // Create the session
         let session = URLSession.shared
         let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
         task.resume()
      }
   }
   
   static func updateTable(table: Table, key: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
      // Create the url to request
      if let urlToReq = URL(string: "http://192.168.0.51:8000/table/update") {
         
         var request = URLRequest(url: urlToReq)
         
          request.httpMethod = "POST"
         
         let size = key.split(separator: ":")[0]
         let item_id = key.split(separator: ":")[1]
         let name = table.items[key]?.name
         let quanity = table.items[key]?.quanity
         let price = table.items[key]?.price
         
         
         // prepare json data
         let json: [String: Any] = ["table_id": table.id,
                                    "order": ["name": name as Any, "item_id":item_id, "price": price as Any, "quanity": quanity as Any, "size": size],
                                    "order_id": table.order_id]
         
         let jsonData = try? JSONSerialization.data(withJSONObject: json)
         
         
         request.httpBody = jsonData
         // Create the session
         let session = URLSession.shared
         let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
         task.resume()
      }
   }
   
   static func cleanTable(table: Table, total: Double ,  completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
      // Create the url to request
      if let urlToReq = URL(string: "http://192.168.0.51:8000/table/clean") {
         
         var request = URLRequest(url: urlToReq)
         
         request.httpMethod = "POST"
         
         // prepare json data
         let json: [String: Any] = ["table_id": table.id,
                                    "order_id": table.order_id,
                                    "total": total]
         
         let jsonData = try? JSONSerialization.data(withJSONObject: json)
         
         
         request.httpBody = jsonData
         // Create the session
         let session = URLSession.shared
         let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
         task.resume()
      }
   }
}
