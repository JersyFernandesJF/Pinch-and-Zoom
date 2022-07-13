//
//  PageModel.swift
//  Pinch
//
//  Created by Jersy Fernandes on 13/07/2022.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
