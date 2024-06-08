//
//  SendMessagesTableViewCell.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import UIKit

class SendMessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var doneImageView2: UIImageView!
    @IBOutlet weak var doneImageView1: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI(message: Messages) {
        
        messageLabel.text = message.messagesText
        if let formattedTime = convertTo12HourFormat(dateString: message.time ?? "") {
            timeLabel.text = formattedTime
        } else {
            print("Failed to convert the date string.")
        }
        if message.reciverRead == true {
            doneImageView1.isHidden = false
            doneImageView1.isHidden = false
            doneImageView1.image = UIImage(named: "Seen")
            doneImageView2.image = UIImage(named: "Seen")
        } else {
            if message.status == "send" {
                doneImageView1.isHidden = true
                doneImageView2.image = UIImage(named: "Unseen")
            } else {
                doneImageView1.isHidden = false
                doneImageView1.isHidden = false
                doneImageView1.image = UIImage(named: "Unseen")
                doneImageView2.image = UIImage(named: "Unseen")
            }
        }
    }
    
    func convertTo12HourFormat(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
