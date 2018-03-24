//
//  ApiHandling.swift
//  Book Inventory
//
//  Created by Ananta Sjartuni on 22/3/18.
//  Copyright © 2018 Sjartuni. All rights reserved.
//

import Foundation

class ApiHandling {
    open func getPSI(with completionHandler: @escaping (String?, Error?) -> Void) {
        
        //let urlPath: String = "https://developers.data.gov.sg/environment/psi"
        let url = NSURL(string: self.preparePSI_URL())
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //let url: NSURL = NSURL(string: urlPath)!
        //let request1: NSURLRequest = NSURLRequest(URL: url)
        let queue:OperationQueue = OperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: queue, completionHandler:{ (response: URLResponse?, data: Data?, error: Error?) -> Void in
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                    //print("ASynchronous\(jsonResult)")
                    let psiCentral = DataParse.getCentralPSI(jsonResult)
                    completionHandler(psiCentral, NSError())
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
    }
    
    private func preparePSI_URL() -> String!{
        var components = URLComponents(string:"https://api.data.gov.sg/v1/environment/psi")
        let datetime = "\(getDate().date!)T\(getDate().time!)"
        //let date = "date=\(getDate().date!)"
        //let dateTimeQuery = URLQueryItem(name:"date_time", value:datetime)
        let dateQuery = URLQueryItem(name:"date_time", value:datetime)
        
        components?.queryItems = [/*dateTimeQuery, */dateQuery]
        return components!.string
        
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

class DataParse {
    class func getCentralPSI(_ dataInput:[String:Any]) -> String{
        guard let items = dataInput["items"] as? [Any] else {
            return "err"
        }
        guard let immediate = items[0] as? [String:Any] else {
            return "err"
        }
        
        guard let reading = immediate["readings"] as? [String:Any] else {
            return "err"
        }
        
        guard let psi24 = reading["psi_twenty_four_hourly"] as? [String:Any] else {
            return "err"
        }
        
        guard let central = psi24["central"] as? Int else {
            return "err"
        }
        print(central)
        
        return "\(central)"
    }
}
