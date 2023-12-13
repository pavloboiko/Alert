//
//  AlertContents.swift
//  Alert
//
//  Created by Ursus on 10/22/20.
//  Copyright © 2020 Aisberg LLC. All rights reserved.
//

import UIKit

public struct AlertContents {
    
    public var icon: UIImage?
    public var title: String = ""
    public var subtitle: String = ""
    public var attributedSubtitle: NSAttributedString?
    public var primaryButtonTitle: String = ""
    public var secondaryButtonTitle: String = ""
    public var verticalStack = false
    
    public init() {}
}

// MARK: Build

public extension AlertContents {
    
    static func icon(_ icon: UIImage?) -> AlertContents {
        var temp = AlertContents()
        temp.icon = icon
        return temp
    }
    
    static func title(_ title: String) -> AlertContents {
        var temp = AlertContents()
        temp.title = title
        return temp
    }
    
    func icon(_ icon: UIImage?) -> AlertContents {
        var temp = self
        temp.icon = icon
        return temp
    }
    
    func title(_ title: String) -> AlertContents {
        var temp = self
        temp.title = title
        return temp
    }
    
    func subtitle(_ subtitle: String) -> AlertContents {
        var temp = self
        temp.subtitle = subtitle
        return temp
    }
    
    func attributedSubtitle(_ subtitle: NSAttributedString) -> AlertContents {
        var temp = self
        temp.attributedSubtitle = subtitle
        return temp
    }
    
    func primaryButtonTitle(_ primaryButtonTitle: String) -> AlertContents {
        var temp = self
        temp.primaryButtonTitle = primaryButtonTitle
        return temp
    }
    
    func secondaryButtonTitle(_ secondaryButtonTitle: String) -> AlertContents {
        var temp = self
        temp.secondaryButtonTitle = secondaryButtonTitle
        return temp
    }
    
    func verticalButtonStack() -> AlertContents {
        var temp = self
        temp.verticalStack = true
        return temp
    }
}
