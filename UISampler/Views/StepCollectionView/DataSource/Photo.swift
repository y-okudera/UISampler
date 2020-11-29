//
//  Photo.swift
//  UISampler
//
//  Created by okudera on 2020/09/23.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

struct Photo {

    var caption = ""
    var comment = ""
    var image: UIImage?

    func heightForCaption(font: UIFont, width: CGFloat) -> CGFloat {
        return caption.height(font: font, width: width)
    }

    func heightForComment(font: UIFont, width: CGFloat) -> CGFloat {
        return comment.height(font: font, width: width)
    }
}

private extension String {

    func height(font: UIFont, width: CGFloat) -> CGFloat {
        let rect = (self as NSString).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )

        return ceil(rect.height)
    }
}
