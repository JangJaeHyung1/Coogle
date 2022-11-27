//
//  Extension.swift
//  Coogle
//
//  Created by jh on 2022/08/07.
//

import UIKit

extension UIView {
    func setShadow(radius: CGFloat = 2, opacity: Float = 0.1, x: Int = 2, y: Int = 2) {
       
       layer.shadowColor = UIColor.gray.cgColor
       layer.masksToBounds = false
       layer.shadowOffset = CGSize(width: x, height: y)
       
       layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
       layer.shadowRadius = radius
       layer.shadowOpacity = Float(opacity)
  }
}

extension UIImage
{
  func resizedImage(Size sizeImage: CGSize) -> UIImage?
  {
      let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: sizeImage.width, height: sizeImage.height))
      UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
      self.draw(in: frame)
      let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      self.withRenderingMode(.alwaysOriginal)
      return resizedImage
  }
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

extension CALayer {
    // Sketch 스타일의 그림자를 생성하는 유틸리티 함수
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}

extension UITabBar {
    // 기본 그림자 스타일을 초기화해야 커스텀 스타일을 적용할 수 있다.
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

extension UILabel {
    // 행간
    static func lblSpacing(lbl: UILabel, spacing: CGFloat) -> UILabel{
        let attrString = NSMutableAttributedString(string: lbl.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lbl.bounds.width * 0.3 * -1
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        lbl.attributedText = attrString
        return lbl
    }
    
    // 자간
    func addCharacterSpacing(_ value: Double = -0.03) {
        let kernValue = self.font.pointSize * CGFloat(value)
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
    
//    func addCharacterSpacing(kernValue:Double = 0.5) {
//        guard let text = text, !text.isEmpty else { return }
//        let string = NSMutableAttributedString(string: text)
//        string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
//        attributedText = string
//    }
}

extension UITextView {
    func addCharacterSpacing(_ value: Double = -0.03) {
        let kernValue = self.font!.pointSize * CGFloat(value)
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
}

extension UITextField {
    func addCharacterSpacing(_ value: Double = -0.03) {
        let kernValue = self.font!.pointSize * CGFloat(value)
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
}

extension NSAttributedString {
    // 행간
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                        value: paragraphStyle,
                                        range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}
extension UIViewController {
    func hideTextFieldKeyboardWhenTappedBackground() {
        let tapEvent = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapEvent.cancelsTouchesInView = false
        view.addGestureRecognizer(tapEvent)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


open class CustomLabel : UILabel {
    @IBInspectable open var characterSpacing:CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }

    }
}


