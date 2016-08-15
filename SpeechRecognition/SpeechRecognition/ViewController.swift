//
//  ViewController.swift
//  SpeechRecognition
//
//  Created by Exilant on 8/15/16.
//  Copyright © 2016 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSSpeechRecognizerDelegate {

    @IBOutlet weak var startStopButton: NSButton!
    @IBOutlet var textView:NSTextView!
    
    var recongnizer = NSSpeechRecognizer()
    var listening = false
    
    let commands = ["Hi Computer","Problem", "Issue", "Happy", "Sad", "Return", "Purchase", "Not Working","How Can I", "I am facing problem with my Phone", "iPhone", "iPad", "Mac Os", "Thank you", "Thanks"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recongnizer?.commands = commands
        startStopButton.title = "Start Listening"
        recongnizer?.delegate = self
        self.textView.isEditable = false
        
        // Do any additional setup after loading the view.
    }

    @IBAction func startStopListing(_ sender: NSButton) {
        
        listening = !listening
        let title =   listening ? "Stop Listening" : "Start Listening"
        listening ? recongnizer?.startListening() : recongnizer?.stopListening()
        sender.title = title
        
    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded
        }
    }

    func speechRecognizer(_ sender: NSSpeechRecognizer, didRecognizeCommand command: String) {
        if recongnizer == sender
        {
        
            textView.isEditable = true
            var response = ""
            switch command {
            case "Hi Computer":
                response = "Hi There, What can I do for you?"
            case "I am facing problem with my Phone":
                response = "Tell me, what kind of issues are you facing?"
            case "problem", "Issue", "Not Working","I am facing problem with my Phone", "Sad":
                response = "I am Sorry about that, Please tell me more about your problem"
            case "Happy":
                response = "Glad to know this"
            case "iPhone", "iPad", "Mac OS":
                response = "How can I help you with this"
            case "Thank you", "Thanks":
                response = "You are Welcome!"
            default:
                response = ""
            }
            
            textView.insertText("\("User: " + command + "\r\r" + "Computer: " + response + "\r\r" + "--------------------" + "\(Date())" + "------------------")" + "\r\r", replacementRange: NSRange(location: 0, length: 0))
            
            let synthesizer = NSSpeechSynthesizer()
            
            synthesizer.startSpeaking(response);
            
            textView.isEditable = false
        
        }
    }

}


