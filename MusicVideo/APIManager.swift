//
//  APIManager.swift
//  MusicVideo
//
//  Created by Michael Rudowsky on 5/2/16.
//  Copyright © 2015 Michael Rudowsky. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: [Video] -> Void ) {
        
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        
        //        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
                
            } else {
                
                let videos = self.parseJson(data)
                
                let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(videos)
                    }
                }
            }
            
        }
        
        task.resume()
    }
    
    func parseJson(data: NSData?) -> [Video] {
        
        do {
            
            if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as AnyObject? {
                
                return JsonDataExtractor.extractVideoDataFromJson(json)
            }
        }
            
        catch {
            print("Failed to parse data: \(error)")
        }
        
        return [Video]()
    }
    
    
}
