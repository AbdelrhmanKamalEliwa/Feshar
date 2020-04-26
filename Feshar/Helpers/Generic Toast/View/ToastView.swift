//
//  ToastView.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/24/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class ToastView: UIView {
    
    //MARK: outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    //MARK: Properties
    var toastHeight: CGFloat {
        let textString = (messageLabel.text ?? "") as NSString
        let textAttributes: [NSAttributedString.Key: Any] = [.font: messageLabel.font!]
        let estimatedTextHeight = textString.boundingRect(with: CGSize(width: 300, height: 2000), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil).height
        let height = estimatedTextHeight + 30
        return height
    }
    
    //MARK: methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ToastView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
}
