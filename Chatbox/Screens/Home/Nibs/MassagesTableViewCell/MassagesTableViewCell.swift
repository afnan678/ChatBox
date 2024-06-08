//
//  MassagesTableViewCell.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 26/01/2024.
//

import UIKit

class MassagesTableViewCell: UITableViewCell {
    @IBOutlet weak var onlineStatusView: UIView!
    @IBOutlet weak var messagesCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
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
    
    
    func setupCell(data: HomeModel) {
        nameLabel.text = data.user.name
        timeLabel.text = data.chat.lastmessageTime
        if data.user.online == true {
            onlineStatusView.backgroundColor = UIColor.systemGreen
        } else {
            onlineStatusView.backgroundColor = UIColor.gray
        }
        if let url = URL(string: data.user.profileUrl) {
            GetImage.getImage(url: url, image: profileImageView)
        }
        // Example usage
        if let formattedString = formatRelativeDate(data.chat.lastmessageTime) {
            timeLabel.text = formattedString
        } else {
            print("Invalid date string")
        }

        if let token = UserDefaults.standard.string(forKey: "Token")  {
            if token == data.chat.messagesId {
                lastMessageLabel.text = "You: \(data.chat.lastmessage)"
            } else {
                lastMessageLabel.text = data.chat.lastmessage
            }
        }
    }
    
    
    func formatRelativeDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = dateFormatter.date(from: dateString) {
            // Check if the date is today
            if Calendar.current.isDateInToday(date) {
                dateFormatter.dateFormat = "h:mm a"
                return dateFormatter.string(from: date)
            }

            // Check if the date is within the last week
            if Calendar.current.isDate(date, equalTo: Date(), toGranularity: .weekOfYear) {
                dateFormatter.dateFormat = "EEEE"
                return dateFormatter.string(from: date)
            }

            // If not today or within the last week, return the date in the format yyyy-MM-dd HH:mm:ss
            dateFormatter.dateFormat = "dd/M/yyyy"
            return dateFormatter.string(from: date)
        }

        return nil // Return nil if the input string couldn't be converted to a date
    }
    
}


