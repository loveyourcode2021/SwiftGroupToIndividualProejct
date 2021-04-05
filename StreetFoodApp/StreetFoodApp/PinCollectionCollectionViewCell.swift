//
//  PinCollectionCollectionViewCell.swift
//  StreetFoodApp
//
//  Created by Dong Yeol Lee on 2021-03-07.
//

import UIKit

class PinCollectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var comment: UILabel!
    
    @IBOutlet weak var Like: UIButton!
    static func nib() -> UINib {
        return UINib(nibName:"PinCollectionCollectionViewCell", bundle: nil)
    }
    
}
