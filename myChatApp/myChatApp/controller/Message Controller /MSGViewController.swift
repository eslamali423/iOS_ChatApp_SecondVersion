//
//  MSGViewController.swift
//  myChatApp
//
//  Created by Eslam Ali  on 13/03/2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import RealmSwift
import Gallery


class MSGViewController: MessagesViewController {
    
    //MARK:- vars
    
    var chatId = ""
    var receiverId = ""
    var receiverName = ""
    let refreshController = UIRefreshControl()
    let micButton  = InputBarButtonItem()
    
    let currentUser = MKSender(senderId : User.currentID , displayName : User.currentUser!.username)
    let mkMessage : [MKMessage] = [] 
    
    
    //MARK:- Initializer
    
    init(chatId: String, receiverId : String , receiverName:String) {
        super.init(nibName: nil, bundle: nil)
        
        self.chatId = chatId
        self.receiverId = receiverId
        self.receiverName = receiverName
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMessageCollectionView()
        configureMessageInputBar()
        
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Conficration for Message Collection View Function
    private func configureMessageCollectionView () {
                messagesCollectionView.messagesDataSource = self
                messagesCollectionView.messageCellDelegate = self
                messagesCollectionView.messagesDisplayDelegate = self
                messagesCollectionView.messagesLayoutDelegate = self
        
        
        scrollsToBottomOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
        messagesCollectionView.refreshControl = refreshController
        
    }
    
    
    //MARK:- configure Input Bar buttons
    private func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.isImagePasteEnabled =  false
        messageInputBar.backgroundView.backgroundColor = .systemBackground
        messageInputBar.inputTextView.backgroundColor = .systemBackground

        
        
        //        messageInputBar.delegate = self
        let attachButton = InputBarButtonItem()
        attachButton.image = UIImage(systemName: "paperclip", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        attachButton.setSize(CGSize(width: 30, height: 30), animated: false)
        attachButton.onTouchUpInside { (item) in
            print("attach button pressed")
            //attach action
            
        }
        
        // add items to messageInputBar stalkView
        messageInputBar.setStackViewItems([attachButton], forStack: .left, animated: false)
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
        
        
       
        
        
        micButton.image = UIImage(systemName: "mic.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        micButton.setSize(CGSize(width: 30, height: 30), animated: false)
        
        // add gesture recognizer
        
       
        // update mic status
        updateMicButtonStatus(show : false)
    }
    
    private func updateMicButtonStatus (show : Bool) {
        if show  /* mic  */{
            messageInputBar.setStackViewItems([micButton], forStack: .right, animated: false)
            messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)
            
        } else /* send Button */ {
            messageInputBar.setStackViewItems([messageInputBar.sendButton], forStack: .right, animated: false)
            messageInputBar.setRightStackViewWidthConstant(to: 55, animated: false)
        }
        
        
    }
    
    
    
}
