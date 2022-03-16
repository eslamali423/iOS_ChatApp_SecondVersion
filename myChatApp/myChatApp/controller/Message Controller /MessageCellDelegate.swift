//
//  MessageCellDelegate.swift
//  myChatApp
//
//  Created by Eslam Ali  on 13/03/2022.
//

import Foundation
import MessageKit
import AVFoundation
import AVKit
import SKPhotoBrowser


extension MSGViewController : MessageCellDelegate {
    
    
    func didTapImage(in cell: MessageCollectionViewCell) {
    
        if let indextPath = messagesCollectionView.indexPath(for: cell) {
      
            let mkMessage =  mkMessages[indextPath.section]
            // check if the message is photo
            if mkMessage.photoItem != nil && mkMessage.photoItem?.image != nil {
               var images = [SKPhoto]()
                let photo = SKPhoto.photoWithImage(mkMessage.photoItem!.image!)
                images.append(photo)
                
                let photoBrowser = SKPhotoBrowser(photos: images)
                
                self.present(photoBrowser, animated: true, completion: nil)
                
            }
            // check if the message is video
            if mkMessage.videoItem != nil && mkMessage.videoItem?.url != nil {
              
                let playerController = AVPlayerViewController()
                let player = AVPlayer(url: mkMessage.videoItem!.url!)
                playerController.player = player
                
                let session  =  AVAudioSession.sharedInstance()
                try! session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
                
                self.present(playerController, animated: true) {
                    playerController.player!.play()
                }
                
                
                
                
                
            }
            
            
        
        }
    }
    
    
    
}

