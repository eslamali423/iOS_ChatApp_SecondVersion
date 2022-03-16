//
//  GlobalFucntions.swift
//  myChatApp
//
//  Created by Eslam Ali  on 10/03/2022.
//

import Foundation
import UIKit
import AVFoundation


func fileNameFromUrl(fileUrl : String) -> String {
    let name = fileUrl.components(separatedBy: "_").last
    let name1 =  name?.components(separatedBy: "?").first
    let name2 = name1?.components(separatedBy: ".").first
    return name2!
}


// this function create Thumbnail Image for Videos
func videoThumbnail (videoUrl : URL) ->  UIImage{
    do {
        let asset =  AVURLAsset(url: videoUrl, options: nil)
        let imageGenerator = AVAssetImageGenerator(asset : asset)
        imageGenerator.appliesPreferredTrackTransform = true
        let cgImage  = try imageGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
        let thumbnail =  UIImage(cgImage: cgImage)
        return thumbnail
    }catch let error {
        print("Error Generating Thumpnail" , error.localizedDescription)
    }

return UIImage(named: "avatar")!
}
