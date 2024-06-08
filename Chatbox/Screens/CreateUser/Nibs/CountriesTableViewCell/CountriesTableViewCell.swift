//
//  CountriesTableViewCell.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dialCodeLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setUPCell(contry: Country) {
        nameLabel.text = contry.name
        dialCodeLabel.text = contry.dialCode
        codeLabel.text = contry.code
    }
}
