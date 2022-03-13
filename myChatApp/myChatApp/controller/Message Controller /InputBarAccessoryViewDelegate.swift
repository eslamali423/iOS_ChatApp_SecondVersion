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
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        print (text)
        inputBar.inputTextView.text = ""
        messageInputBar.invalidatePlugins()
        
    }
    
    
}
