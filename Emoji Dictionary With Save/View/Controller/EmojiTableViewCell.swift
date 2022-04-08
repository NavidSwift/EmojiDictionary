//
//  EmojiTableViewCell.swift
//  Emoji Dictionary With Save
//
//  Created by Navid on 1/10/22.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    func updateLabels(emoji: Emoji){
        
        symbolLabel.text = emoji.symbol
        nameLabel.text = emoji.name
        descriptionLabel.text = emoji.description
        }

}
