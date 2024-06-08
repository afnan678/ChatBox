//
//  ContactsTableViewCell.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(contact: ContactsModel) {
        if let token = UserDefaults.standard.string(forKey: "Token"), token == contact.id  {
            nameLabel.text = contact.name
            aboutLabel.text = "You"
            if let url = URL(string: contact.profileUrl) {
                GetImage.getImage(url: url, image: profileImageView)
            }
        } else {
            nameLabel.text = contact.name
            aboutLabel.text = contact.about
            if let url = URL(string: contact.profileUrl) {
                GetImage.getImage(url: url, image: profileImageView)
            }
        }
    }
}
