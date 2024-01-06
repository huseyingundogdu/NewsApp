//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Huseyin on 19/12/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    var shareButtonFnc: (() -> ())?
    var saveButtonFnc: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func shareButtonClicked(_ sender: Any) {
        shareButtonFnc?()
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        saveButtonFnc?()
    }
    
    override func prepareForReuse() {
        
    }
    
}
