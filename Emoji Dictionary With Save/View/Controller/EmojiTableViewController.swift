//
//  EmojiTableViewController.swift
//  Emoji Dictionary With Save
//
//  Created by Navid on 1/10/22.
//

import UIKit

class EmojiTableViewController: UITableViewController {
   
    var emojis: [Emoji] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let loadedEmoji = Emoji.loadFromFile() {
            self.emojis = loadedEmoji
        }else {
            self.emojis = Emoji.sampleEmoji()
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        
    }
    @IBAction func editButtonPressed(_ sender: Any) {
        
        let editingMode = tableView.isEditing
        tableView.setEditing(!editingMode, animated: true)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return emojis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Emoji",for: indexPath) as! EmojiTableViewCell
       
        let emoji = emojis[indexPath.row]
        cell.updateLabels(emoji: emoji)
        cell.showsReorderControl = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Emoji.saveToFile(emoji: emojis)
            
        }
    }
    

//    @IBSegueAction func addEmoji(_ coder: NSCoder) -> EmojiFormTableViewController? {
//        return EmojiFormTableViewController(coder: coder, emoji: nil)
//    }
//
//
//    @IBSegueAction func editEmoji(_ coder: NSCoder, sender: Any?) -> EmojiFormTableViewController? {
//
//        guard let cell = sender as? UITableViewCell,let indexPath = tableView.indexPath(for: cell) else {return nil}
//
//        return EmojiFormTableViewController(coder: coder, emoji: emojis[indexPath.row])
//    }
    
    
    
    @IBAction func unwindToTable(seague: UIStoryboardSegue) {
        
        guard seague.identifier == "saveEmoji",let sourceControl = seague.source as? EmojiFormTableViewController,let emoji = sourceControl.emoji else {return}

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            Emoji.saveToFile(emoji: emojis)
        }else {
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.reloadRows(at: [newIndexPath], with: .automatic)
            Emoji.saveToFile(emoji: emojis)
        }
        
        
    }
    
    
    
    @IBSegueAction func addEditForm(_ coder: NSCoder, sender: Any?) -> EmojiFormTableViewController? {
        guard let cell = sender as? UITableViewCell,let indexPath = tableView.indexPath(for: cell) else {return EmojiFormTableViewController(coder: coder, emoji: nil)}
        
        
        return EmojiFormTableViewController(coder: coder, emoji: emojis[indexPath.row])
    }
    
    

    
}
