//
//  JsonDataExtractor.swift
//  MusicVideo
//
//  Created by Michael Rudowsky on 5/2/16.
//  Copyright © 2016 Michael Rudowsky. All rights reserved.
//

import Foundation

class JsonDataExtractor {
    
    static func extractVideoDataFromJson(videoDataObject: AnyObject) -> [Video] {
        
        guard let videoData = videoDataObject as? JSONDictionary else { return [Video]() }
        
        var videos = [Video]()
        
        if let feeds = videoData["feed"] as? JSONDictionary, entries = feeds["entry"] as? JSONArray {
            
            for (index, data) in entries.enumerate() {
                
                
                var vName = " ", vRights = "", vPrice = "", vImageUrl = "",
                vArtist = "", vVideoUrl = "", vImid = "", vGenre = "",
                vLinkToiTunes = "", vReleaseDte = ""
                
                
                
                // Video name
                if let imName = data["im:name"] as? JSONDictionary,
                    label = imName["label"] as? String {
                    vName = label
                }
                
                
                // The Studio Name
                if let rightsDict = data["rights"] as? JSONDictionary,
                    label = rightsDict["label"] as? String {
                    vRights = label
                }
                
                
                
                // Price of Video
                
                if let imPrice = data["im:price"] as? JSONDictionary,
                    label = imPrice["label"] as? String {
                    vPrice = label
                }
                
                
                
                
                // The Video Image
                if let imImage = data["im:image"] as? JSONArray,
                    image = imImage[2] as? JSONDictionary,
                    label = image["label"] as? String {
                    vImageUrl = label.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
                }
                
                
                
                // The Artist Name
                if let imArtist = data["im:artist"] as? JSONDictionary,
                    label = imArtist["label"] as? String {
                    vArtist = label
                }
                
                
                
                
                //Video Url
                if let link = data["link"] as? JSONArray,
                    vUrl = link[1] as? JSONDictionary,
                    attributes = vUrl["attributes"] as? JSONDictionary,
                    href = attributes["href"] as? String {
                    vVideoUrl = href
                }
                
                
                
                
                // The Artist ID for iTunes Search API
                if let id = data["id"] as? JSONDictionary,
                    attributes = id["attributes"] as? JSONDictionary,
                    Imid = attributes["im:id"] as? String {
                    vImid = Imid
                }
                
                
                
                // The Genre
                if let category = data["category"] as? JSONDictionary,
                    attributes = category["attributes"] as? JSONDictionary,
                    term = attributes["term"] as? String {
                    vGenre = term
                }
                
                
                
                // Video Link to iTunes
                if let id = data["id"] as? JSONDictionary,
                    label = id["label"] as? String {
                    vLinkToiTunes = label
                }
                
                
                
                
                // The Release Date
                if let imReleaseDate = data["im:releaseDate"] as? JSONDictionary,
                    attributes = imReleaseDate["attributes"] as? JSONDictionary,
                    label = attributes["label"] as? String {
                    vReleaseDte = label
                }
                
                
                
                let currentVideo = Video(vRank: index + 1, vName: vName, vRights: vRights, vPrice: vPrice, vImageUrl: vImageUrl, vArtist: vArtist, vVideoUrl: vVideoUrl, vImid: vImid, vGenre: vGenre, vLinkToiTunes: vLinkToiTunes, vReleaseDte: vReleaseDte)
                
                videos.append(currentVideo)
                
                
            }
            
        }
        
        return videos
        
    }
}

