//
//  ApiHandling.swift
//  Book Inventory
//
//  Created by Ananta Sjartuni on 22/3/18.
//  Copyright © 2018 Sjartuni. All rights reserved.
//

import Foundation

enum apiURLType {
    case PSI_URL
    case PM_URL
    case WEATHER_URL
}

class ApiHandling {
    
    public func getAPI(_ apiType:apiURLType, with completionHandler: @escaping (String?, Error?) -> Void) {
        
        let url = NSURL(string: self.prepareURL(apiType))
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //let url: NSURL = NSURL(string: urlPath)!
        //let request1: NSURLRequest = NSURLRequest(URL: url)
        let queue:OperationQueue = OperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: queue, completionHandler:{ (response: URLResponse?, data: Data?, error: Error?) -> Void in
            
            if error != nil {
                completionHandler("err", NSError())
            }
            else {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                        //print("ASynchronous\(jsonResult)")
                        if apiType == apiURLType.PSI_URL {
                            let psiCentral = DataParse.getCentralPSI(jsonResult)
                            completionHandler(psiCentral, NSError())
                        }
                        else if apiType == apiURLType.PM_URL {
                            let pm25HighLow = DataParse.getCentralPM25(jsonResult)
                            completionHandler(pm25HighLow, NSError())
                        }
                        else if apiType == apiURLType.WEATHER_URL {
                            let weatherCentral = DataParse.getCentralWeather(jsonResult)
                            completionHandler(weatherCentral, NSError())

                        }
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    private func prepareURL(_ urlType:apiURLType) -> String!{
        var strURL:String?
        
        if urlType == apiURLType.PSI_URL {
            strURL = "https://api.data.gov.sg/v1/environment/psi"
        }
        else if urlType == apiURLType.PM_URL {
            strURL = "https://api.data.gov.sg/v1/environment/pm25"
        }
        else if urlType == apiURLType.WEATHER_URL {
            strURL = "https://api.data.gov.sg/v1/environment/24-hour-weather-forecast"
        }
        
        var components = URLComponents(string:strURL!)
        let datetime = "\(getDate().date!)T\(getDate().time!)"
        //let date = "date=\(getDate().date!)"
        //let dateTimeQuery = URLQueryItem(name:"date_time", value:datetime)
        var dateQuery = URLQueryItem(name:"date_time", value:datetime)
        
        if urlType == apiURLType.WEATHER_URL {
            dateQuery = URLQueryItem(name:"date", value:getDate().date!)
        }
        
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

    class func getCentralPM25(_ dataInput:[String:Any]) -> String{
        var low = 999
        var high = 0
        guard let items = dataInput["items"] as? [Any] else {
            return "err"
        }
        guard let immediate = items[0] as? [String:Any] else {
            return "err"
        }
        
        guard let reading = immediate["readings"] as? [String:Any] else {
            return "err"
        }
        
        guard let pm25 = reading["pm25_one_hourly"] as? [String:Any] else {
            return "err"
        }
        
        
        for pmLoc in pm25 {
            let val = pmLoc.value as? Int
            if val! < low  {
                low = (pmLoc.value as? Int)!
            }
            
            if val! > high {
                high = (pmLoc.value as? Int)!
            }
        }
        
        print("\(low) - \(high)")
        
        return "\(low) - \(high)"
    }

    class func getCentralWeather(_ dataInput:[String:Any]) -> String{
        guard let items = dataInput["items"] as? [Any] else {
            return "err"
        }
        
        if items.count == 0 {
            return "no data"
        }
        guard let immediate = items[3] as? [String:Any] else {
            return "err"
        }
        
        guard let generals = immediate["general"] as? [String:Any] else {
            return "err"
        }
        
        guard let temperatur = generals["temperature"] as? [String:Any] else {
            return "err"
        }
        
        guard let low = temperatur["low"] as? Int else {
            return "err"
        }
        guard let high = temperatur["high"] as? Int else {
            return "err"
        }
        print("\(low)-\(high)")
        
        return "\(low)°-\(high)°"
    }

}
