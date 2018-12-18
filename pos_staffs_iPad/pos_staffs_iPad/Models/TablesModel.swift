//
//  TablesModel.swift
//  pos_staffs_iPad
//
//  Created by Kim Do on 12/17/18.
//  Copyright © 2018 Kim Do. All rights reserved.
//

import Foundation

class TablesMode{
   static func getAll(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
      let url = URL(string: "http://192.168.0.51:8000/tables")
      
      let session = URLSession.shared
      
      let task = session.dataTask(with: url!, completionHandler: completionHandler)
      
      task.resume()
   }
}
