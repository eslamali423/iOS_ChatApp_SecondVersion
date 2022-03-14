//
//  messageDataSource.swift
//  myChatApp
//
//  Created by Eslam Ali  on 13/03/2022.
//

import Foundation
import MessageKit

extension MSGViewController : MessagesDataSource {
    
    
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return mkMessages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return mkMessages.count
    }
 
    // this function to set data or pull for more messages in sections
    // cell top label
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
   
        if indexPath.section % 3 == 0 {
            let showLoadMore = false
            let text = showLoadMore ? "Pull To Load More Messages"  : MessageKitDateFormatter.shared.string(from: message.sentDate)
       
            let font  =  showLoadMore ? UIFont.systemFont(ofSize: 13) : UIFont.boldSystemFont(ofSize: 10)
            let color =  showLoadMore ? UIColor.systemBlue : UIColor.darkGray
            
            return NSAttributedString(string: text, attributes: [.font : font, .foregroundColor: color])
            
        
        }
        
        
        return nil
    }
    
    // this function to set status [sent, read] and time for the last messag
    // cell bottom label
    
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        if isFromCurrentSender(message: message) {
            let message = mkMessages[indexPath.section]
            let status = indexPath.section == mkMessages.count - 1 ? message.status + " " + MessageKitDateFormatter.shared.string(from: message.sentDate)  :  " "
            
            let font = UIFont.boldSystemFont(ofSize: 10)
            let color =  UIColor.darkGray
            return NSAttributedString(string: status, attributes: [.font : font, .foregroundColor : color])
        }
        
        return nil
    }
    
    // this function to set time for every message
    // message bottom label
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        if indexPath.section != mkMessages.count - 1 {
            let font = UIFont.boldSystemFont(ofSize: 10)
            let color =  UIColor.darkGray
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [.font : font, .foregroundColor : color])
        }
    return nil
    }
    
}

