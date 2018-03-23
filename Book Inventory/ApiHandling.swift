//
//  ApiHandling.swift
//  Book Inventory
//
//  Created by Ananta Sjartuni on 22/3/18.
//  Copyright © 2018 Sjartuni. All rights reserved.
//

import Foundation

class ApiHandling{
    open func getPSI(with completionHandler: @escaping (String?, Error?) -> Void) {
        
        //let urlPath: String = "https://developers.data.gov.sg/environment/psi"
        let url = NSURL(string: "https://developers.data.gov.sg/environment/psi")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        //let url: NSURL = NSURL(string: urlPath)!
        //let request1: NSURLRequest = NSURLRequest(URL: url)
        let queue:OperationQueue = OperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: queue, completionHandler:{ (response: URLResponse?, data: Data?, error: Error?) -> Void in
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    print("ASynchronous\(jsonResult)")
                    completionHandler("test", NSError())
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
    }
    
    private func getDate() -> (date:String?, time:String?) {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: Date())
        df.dateFormat = "HH:mm:ss"
        let time = df.string(from: Date())
        return (date, time)
    }
}
