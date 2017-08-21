//
//  Reuseable.swift
//  FullImageController
//
//  Created by Mingyoung on 2017/8/16.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        // I like to use the class's name as an identifier
        // so this makes a decent default value.
        return String(describing: Self.self)
    }
    
    static var nib: UINib? { return UINib(nibName: self.reuseIdentifier, bundle: nil) }
}

extension UITableViewCell: Reusable {
    
}
