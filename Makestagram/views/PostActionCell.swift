//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Jamee Krzanich on 6/28/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

// define a protocol that every delegate of the PostActionCell must conform to
protocol PostActionCellDelegate: class {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}
class PostActionCell: UITableViewCell {
    @IBOutlet weak var likesLabel: UILabel!

    @IBOutlet weak var likesButton: UIButton!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    weak var delegate: PostActionCellDelegate?

    static let height: CGFloat = 46
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // notify the delegate when users tap on the like button
    @IBAction func likesButtonTapped(_ sender: UIButton) {
        delegate?.didTapLikeButton(sender, on: self)
    }
}
