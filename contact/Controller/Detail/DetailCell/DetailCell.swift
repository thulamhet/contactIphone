//
//  DetailCell.swift
//  contact
//
//  Created by Nguyễn Công Thư on 24/08/2022.
//

import UIKit

class DetailCell: UITableViewCell {
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
