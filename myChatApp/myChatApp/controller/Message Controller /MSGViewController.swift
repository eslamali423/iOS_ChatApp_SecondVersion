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
    var mkMessages : [MKMessage] = []
    var allLocalMessages : Results<LocalMessage>!
    let realm = try! Realm()
    
    var notificationToken : NotificationToken?
    
    
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
        loadMessages()
        
        
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
    
    //MARK:- Send Message Function
    func send(text : String?, photo : UIImage?, video : Video?, audio : String? , location : String?, audioDuration: Float = 0.0)  {
        
        Outgoing.shared.sendMessage(chatId: chatId, text: text, photo: photo, video: video, audio: audio, location: location, memberIds: [User.currentID, receiverId])
        
    }
    
    //MARK:- Load Messages
    func loadMessages()  {
        let pridecate = NSPredicate(format: "chatRoomId = %@", chatId)
        allLocalMessages = realm.objects(LocalMessage.self).filter(pridecate).sorted(byKeyPath: KDATE, ascending: true)
        

        // OBserve(Listenr) To Firebase using Notification Token
        
        notificationToken = allLocalMessages.observe({ (change  : RealmCollectionChange ) in
            switch change {
            case .initial:
                self.insertMKMessages()
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToBottom(animated: true)
  
            case .update(_, _, insertions: let insertions, _):
                for index in insertions {
                    self.insertMKMessage(localMessage: self.allLocalMessages[index])
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToBottom(animated: true)
                }
            case .error(let error):
                print("error", error.localizedDescription)
            }
        })
        
        
    }
    
    
    
    private func insertMKMessage(localMessage : LocalMessage){
        let incoming = Incoming(messageViewController: self)
        let mkMessage = incoming.createMKMessage(localMessage: localMessage)
        mkMessages.append(mkMessage)
    }
    
    private func insertMKMessages(){
        
        for localMessage in allLocalMessages {
            insertMKMessage(localMessage: localMessage)
        }
        
    }
    
    
}
