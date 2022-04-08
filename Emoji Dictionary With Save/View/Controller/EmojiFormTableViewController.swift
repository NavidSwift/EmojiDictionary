//
//  EmojiFormTableViewController.swift
//  Emoji Dictionary With Save
//
//  Created by Navid on 1/10/22.
//

import UIKit

class EmojiFormTableViewController: UITableViewController {

    var emoji: Emoji?
    
    @IBOutlet var symbolTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var usageTextField: UITextField!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    init?(coder: NSCoder,emoji: Emoji?){
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        updateView()
        updateSaveButton()
    }
    
    

    // MARK: - Table view data source

    
    func updateView(){
        
        if let emoji = emoji {
            
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
            
        }
        
    }
    
   @IBAction func updateSaveButton(){
        
       
       let name = nameTextField.text ?? ""
       let desriptionText = descriptionTextField.text ?? ""
       let usage = usageTextField.text ?? ""
        
       saveButton.isEnabled = isSingleEmoji(symbolTextField) && !name.isEmpty && !desriptionText.isEmpty && !usage.isEmpty
           
       
        
    }
    
    func isSingleEmoji(_ text: UITextField) -> Bool{
        
        guard let symbol = text.text,symbol.count  == 1 else {return false}
        
       let isEmoji = symbol.unicodeScalars.first?.properties.isEmoji ?? false
       let isEmojiPresentation = symbol.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        
        return isEmoji || isEmojiPresentation
        
    }
    
       @IBAction func saveEmoji(){
        
        let symbol = symbolTextField.text!
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
         
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
        
        performSegue(withIdentifier: "saveEmoji", sender: self)
        
        
    }
    
    
    

  

}
