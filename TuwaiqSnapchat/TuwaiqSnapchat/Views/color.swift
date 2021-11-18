//
//  color.swift
//  TuwaiqSnapchat
//
//  Created by HANAN on 13/04/1443 AH.
//

import UIKit
import Foundation

//enum or stract
enum colors {
  static let button = UIColor(red:0.58, green:0.26, blue:0.25, alpha:1.0)
  static let backgroundDarckcolor = UIColor(red: (51/255), green: (161/255), blue: (152/255), alpha: 1)
  static let backgroundLightcolor = UIColor(red: (15/255), green: (164/255), blue: (184/255), alpha: 1)
  static let textFieldsBorder = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
  static let textFieldsBackground = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.1)
  static let titlesColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
}
// Gradiant background
extension UIView {
  // all these must be add in the extionsion ^
  func setGradiantView() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.bounds
    gradientLayer.colors = [colors.backgroundLightcolor.cgColor, colors.backgroundDarckcolor.cgColor]
    layer.insertSublayer(gradientLayer, at: 0)
  }
}
// textfield icons :)
extension UIImageView {
  func iconsImageView (){
    self.contentMode = .scaleAspectFit
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}
//all lbls
extension UILabel {
  func changeUILabel( title: String , size: CGFloat ){
    self.text = title
    self.textColor = colors.titlesColor
    self.translatesAutoresizingMaskIntoConstraints = false
    self.font = UIFont(name: "Futura", size: size)
}
}
extension UIButton {
  func changeUIButton (title : String , color : UIColor){
    self.setTitle(title, for: .normal)
    self.backgroundColor = color
    self.translatesAutoresizingMaskIntoConstraints = false
    self.layer.cornerRadius = 25
    self.setTitleColor(colors.titlesColor, for: .normal)
  }
}








