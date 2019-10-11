//
//  NewsCollectionViewCell.swift
//  TopNews
//
//  Created by Sujata Chakraborty on 11/10/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet var image : CustomImageView!
    @IBOutlet var title  : UILabel!
    @IBOutlet var contentOrDescription  : UILabel!
    @IBOutlet var timeLabel  : UILabel!
    @IBOutlet var sourceLabel  : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with model: NewsList.FetchNews.ViewModel.DisplayNews) {
        
        self.image.setFallbackImageForRequest(fallBack:UIImage.init(named: "fallback-packshot") ?? UIImage())
        self.image.setHighResImageURL(highResImageURL: model.imageURL, title: "", handler: nil);
        title.text = model.title
        
        if self.tag == 0 || self.tag % Constants.kHightLightnewsItemInterval == 0
        {
            contentOrDescription.text = model.content
        }
        else
        {
            contentOrDescription.text = model.description
        }
        
        sourceLabel.text = model.source
        
        timeLabel.text = model.time
        
    }
    
    override func prepareForReuse() {
        
        self.image.image = nil
        self.image.setFallbackImageForRequest(fallBack:UIImage.init(named: "fallback-packshot") ?? UIImage())

    }
}
