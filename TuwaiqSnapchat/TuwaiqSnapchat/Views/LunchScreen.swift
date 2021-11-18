//
//  LunchScreen.swift
//  TuwaiqSnapchat
//
//  Created by HANAN on 13/04/1443 AH.
//

import UIKit


//create;, add as subview & layout

class LaunchScreen: UIViewController {
  var timer = Timer()
    
  //1- create logo image

  lazy var logo : UIImageView = {
    let logo = UIImageView()
    logo.translatesAutoresizingMaskIntoConstraints = false
    logo.image = UIImage(named: "Logo")
    logo.contentMode = .scaleAspectFit
    logo.layer.masksToBounds = true
    logo.layer.cornerRadius = logo.bounds.width/2
    return logo
  }()
    
    
  lazy var welcomemessagelbl: UILabel = {
    $0.changeUILabel(title: "Welcome", size: 30)
    return $0
  }(UILabel())
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
      
      
    //image
    self.logo.layer.masksToBounds = true
    self.logo.layer.cornerRadius = 40
      
      
    // background
    let background = UIImageView(frame: UIScreen.main.bounds)
    background.image = UIImage(named: "background")
    background.contentMode = UIView.ContentMode.scaleAspectFill
      

    //add gradientView in the top of background view
   let gradientView = UIView()
    gradientView.frame = view.frame
    gradientView.alpha = 0.8
    gradientView.setGradiantView()
      
    // add :)
    self.view.addSubview(gradientView)
    // 2- add logo & message as subview
    self.view.addSubview(self.logo)
    self.view.addSubview(self.welcomemessagelbl)
    // 3- MARK: layout
    NSLayoutConstraint.activate([
    // for safe area ..
      self.logo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 40 ),
      self.logo.widthAnchor.constraint(equalToConstant: 200),
      self.logo.heightAnchor.constraint(equalToConstant: 200),
    // make logo in the center
      self.logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    // message layout
      self.welcomemessagelbl.topAnchor.constraint(equalTo: self.logo.bottomAnchor, constant: 40),
      self.welcomemessagelbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    //create timer .
    timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(mainView), userInfo: nil, repeats: true)
    }
 // move
@objc func mainView(_ sender: UIButton) {
  let VC = SignInVC()
  // delete ,,,
// UIView.animate(withDuration: 0.3) {
    VC.modalPresentationStyle = .fullScreen
    self.present(VC, animated: true, completion: nil)
    //stop timer ..
    self.timer.invalidate()
  }
}


