//
//  AlertOptions.swift
//  Alert
//
//  Created by Ursus on 10/22/20.
//  Copyright © 2020 Aisberg LLC. All rights reserved.
//

import RxRelay

public struct AlertOptions {
    
    public var contents: AlertContents
    
    public var callback: PublishRelay<Int>
    
    public init(contents: AlertContents, callback: PublishRelay<Int> = .init()) {
        self.contents = contents
        self.callback = callback
    }
}
