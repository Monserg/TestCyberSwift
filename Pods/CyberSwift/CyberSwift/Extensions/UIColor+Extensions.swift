//
//  UIColor+Extensions.swift
//  Golos
//
//  Created by msm72 on 26.05.2018.
//  Copyright © 2018 golos. All rights reserved.
//
//  https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values

import Foundation
import SwiftTheme

// Theme: day & moon
public let whiteColorPickers: ThemeColorPicker                          =   [ "#ffffff", "#ffffff" ]
public let whiteVividBluePickers: ThemeColorPicker                      =   [ "#ffffff", "#0433ff" ]
public let whiteBlackColorPickers: ThemeColorPicker                     =   [ "#ffffff", "#000000" ]
public let whiteVeryDarkGrayPickers: ThemeColorPicker                   =   [ "#ffffff", "#333333" ]
public let whiteVeryDarkGrayishRedPickers: ThemeColorPicker             =   [ "#ffffff", "#393636" ]

public let lightGrayishBlueWhiteColorPickers: ThemeColorPicker          =   [ "#f2f4f7", "#ffffff" ]
public let lightGrayishBlueBlackColorPickers: ThemeColorPicker          =   [ "#f2f4f7", "#000000" ]

public let veryLightGrayColorPickers: ThemeColorPicker                  =   [ "#dbdbdb", "#dbdbdb" ]
public let veryLightGrayVeryDarkGrayColorPickers: ThemeColorPicker      =   [ "#dbdbdb", "#5a5a5a" ]

public let darkGrayPickers: ThemeColorPicker                            =   [ "#333333", "#333333" ]
public let darkGrayWhiteColorPickers: ThemeColorPicker                  =   [ "#7d7d7d", "#ffffff" ]

public let blackWhiteColorPickers: ThemeColorPicker                     =   [ "#000000", "#ffffff" ]
public let darkGrayishBluePickers: ThemeColorPicker                     =   [ "#9b9fa2", "#9b9fa2" ]
public let veryDarkGrayWhiteColorPickers: ThemeColorPicker              =   [ "#333333", "#ffffff" ]
public let vividBlueWhiteColorPickers: ThemeColorPicker                 =   [ "#1298ff", "#ffffff" ]
public let vividBlueColorPickers: ThemeColorPicker                      =   [ "#1298ff", "#1298ff" ]
public let darkModerateBlueColorPickers: ThemeColorPicker               =   [ "#4469af", "#4469af" ]
public let grayWhiteColorPickers: ThemeColorPicker                      =   [ "#a6a6a6", "#ffffff" ]
public let verySoftBlueColorPickers: ThemeColorPicker                   =   [ "#a0d6fd", "#a0d6fd" ]
public let softBlueColorPickers: ThemeColorPicker                       =   [ "#6a80f5", "#6a80f5" ]
public let grayishRedColorPickers: ThemeColorPicker                     =   [ "#c6c5c5", "#c6c5c5" ]

public let lightGrayWhiteColorPickers: ThemeColorPicker                 =   [ "#c1c1c1", "#ffffff" ]
public let redWhiteColorPickers: ThemeColorPicker                       =   [ "#ff0000", "#ffffff" ]
public let blueWhiteColorPickers: ThemeColorPicker                      =   [ "#0433ff", "#ffffff" ]
public let brightBlueWhiteColorPickers: ThemeColorPicker                =   [ "#2f7dfb", "#ffffff" ]
public let softRedColorPickers: ThemeColorPicker                        =   [ "#e34646", "#e34646" ]

public let blackWhiteDictionaryPickers: ThemeDictionaryPicker           =   ThemeDictionaryPicker.pickerWithAttributes([[NSAttributedString.Key.foregroundColor: UIColor(hexString: "#000000")], [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#ffffff")]])

public let veryLightGrayCGColorPickers: ThemeCGColorPicker              =   [ "#dbdbdb", "#dbdbdb" ]
public let whiteVeryDarkGrayCGColorPickers: ThemeCGColorPicker          =   [ "#ffffff", "#5a5a5a" ]
public let blackVeryDarkGrayCGColorPickers: ThemeCGColorPicker          =   [ "#000000", "#5a5a5a" ]

public let grayWhiteActivityIndicatorViewStylePicker                    =   ThemeActivityIndicatorViewStylePicker.pickerWithStyles([.gray, .white])

extension UIColor {
    public static var myAppRed: UIColor {
        return UIColor(red: 1, green: 0.1, blue: 0.1, alpha: 1)
    }
    
    public static var myAppGreen: UIColor {
        return UIColor(red: 0, green: 1, blue: 0, alpha: 1)
    }
    
    public static var myAppBlue: UIColor {
        return UIColor(red: 0, green: 0.2, blue: 0.9, alpha: 1)
    }

    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        
        Scanner(string: hex).scanHexInt32(&int)
        let alpha, red, green, blue: UInt32
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }
    
    class func colorForNavBar(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        // Or if you need a thinner border :
        // let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
