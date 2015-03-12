//
//  UIView.swift
//  UWifi
//
//  Created by 唐华嶓 on 1/12/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import UIKit

extension UIView {
    /// Return a suitable height of this text with the 'width' and 'font'
    class func heightOfText(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }

    /// Return number of lines fo txt break line by String "\n"
    ///
    /// :returns: number of lines
    class func numberOfLines(txt: String, maxCharactersPerLine: Int) -> CGFloat {
        let linesBySparetedString = CGFloat((txt as NSString).componentsSeparatedByString("\n").count + 1)
        let linesByTextLength = numberOfLinesForMessage(txt, maxCharactersPerLine: maxCharactersPerLine)
        return max(linesBySparetedString, linesByTextLength)
    }

    private class func numberOfLinesForMessage(txt: NSString, maxCharactersPerLine: Int) -> CGFloat {
        return CGFloat(txt.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)) / CGFloat(maxCharactersPerLine) + 1
    }
}
