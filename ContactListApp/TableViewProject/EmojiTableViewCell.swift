//
//  EmojiTableViewCell.swift
//  TableViewProject
//
//  Created by Bakhtiyarov Fozilkhon on 02.10.2022.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emojiImage: UIImageView!
    @IBOutlet weak var imagiName: UILabel!
    @IBOutlet weak var imojiDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(object: Prezident) {
        self.emojiImage.image = object.image
        self.imagiName.text = object.name
        self.imojiDescription.text = object.description
        self.emojiImage.setRounded()
    }
}
