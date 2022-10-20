//
//  DesignSystem.swift
//  Coogle
//
//  Created by jh on 2022/08/07.
//

import UIKit

struct BaseFont {
    
    private static let logoFont = "Metropolis-BlackItalic"
    private static let notoBoldFont = "NotoSansKR-Bold"
    private static let notoRegularFont = "NotoSansKR-Regular"
    private static let metroRgItFont = "Metropolis-RegularItalic"
    private static let metroBoldFont = "Metropolis-Bold"
    private static let sfHvFont = "SF-Pro-Text-Heavy"
    
    static let logo = UIFont(name: logoFont, size: 23)
    static let metroRgIt = UIFont(name: metroRgItFont, size: 15)
    static let metroBold = UIFont(name: metroBoldFont, size: 13)
    
    static let detailTitle = UIFont(name: notoBoldFont, size: 21)
    static let menuTitle = UIFont(name: notoBoldFont, size: 17)
    static let bold = UIFont(name: notoBoldFont, size: 15)
    
    
    static let title = UIFont(name: notoRegularFont, size: 21)
    static let normal = UIFont(name: notoRegularFont, size: 15)
    static let subTitle = UIFont(name: notoRegularFont, size: 13)
    static let difficulty = UIFont(name: notoRegularFont, size: 11)
    
    static let content = UIFont(name: notoRegularFont, size: 25)
    static let sub = UIFont(name: notoRegularFont, size: 11)
    
    static let step = UIFont(name: sfHvFont, size: 21)
}

struct BaseColor {
    static let unSelected = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
    static let main = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let sub = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    static let tint = UIColor(red: 1, green: 0.48, blue: 0, alpha: 1)
    static let difficulty = UIColor(red: 0.296, green: 0.366, blue: 1, alpha: 1)
    static let difficultyBg = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
    static let btnColor =  UIColor(red: 1, green: 0.25, blue: 0.25, alpha: 1)
    static let placeholder = UIColor(red: 0.646, green: 0.646, blue: 0.646, alpha: 1)
    static let border = UIColor(red: 0.742, green: 0.742, blue: 0.742, alpha: 1)
    
}

