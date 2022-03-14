//
//  InputBarAccessoryViewDelegate.swift
//  myChatApp
//
//  Created by Eslam Ali  on 13/03/2022.
//

import Foundation
import InputBarAccessoryView

extension MSGViewController : InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
       print("typing")
    }
    // Did Tap Send Button
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        send(text: text, photo: nil, video: nil, audio: nil, location: nil)
        
        
        inputBar.inputTextView.text = ""
        messageInputBar.invalidatePlugins()
        
    }
    
    
}
