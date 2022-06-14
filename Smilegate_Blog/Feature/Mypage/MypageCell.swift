//
//  MypageCell.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/11.
//

import UIKit

class MypageCell: UITableViewCell {
    let manager = StorageManager.shared
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateUI(info: Posting) {
        guard info.imageURL != "" else {
            imgView.image = UIImage(named: "img_smilegate")
            titleLabel.text = info.title
            nameLabel.text = info.userName
            return
        }
        imgView.image = manager.downloadImage(urlString: info.imageURL)
        titleLabel.text = info.title
        nameLabel.text = info.userName
    }
}
