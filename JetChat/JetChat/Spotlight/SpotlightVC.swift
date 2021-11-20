//
//  spotlightVC.swift
//  JetChat
//
//  Created by MacBook on 12/04/1443 AH.
//

import UIKit

 class SpotlightVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


     override func viewDidLoad() {
         super.viewDidLoad()
         
         view.backgroundColor = UIColor.darkText
         let feedLbl = UILabel()
         feedLbl.text = "Spotlight".localized()
         feedLbl.textColor = .systemBackground
         feedLbl.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(feedLbl)
         feedLbl.font = .boldSystemFont(ofSize: 40)
         NSLayoutConstraint.activate([
            feedLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
         ])

         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.backgroundColor = .white
         collectionView.alwaysBounceVertical = true
         collectionView.register(SpotlightCell.self, forCellWithReuseIdentifier: "cell")
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(collectionView)
         NSLayoutConstraint.activate([
             collectionView.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 16),
             collectionView.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -16),
             collectionView.topAnchor.constraint(equalTo: feedLbl.bottomAnchor, constant: 10),
             collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
         ])
         

     }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return blogsArt.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SpotlightCell
         let data = blogsArt[indexPath.row]

         cell.blogImgCell.image = data
         cell.blogImgCell.clipsToBounds = true
         return cell
     }

     func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
             return CGSize(width: 350, height: 400)
         }

     func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
     }

     func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 2
     }
 }

var blogsArt = [
    UIImage(named: "1"),
    UIImage(named: "2"),
    UIImage(named: "3"),
    UIImage(named: "4"),
    UIImage(named: "5"),
    UIImage(named: "6"),
    UIImage(named: "7"),
    UIImage(named: "8"),
    UIImage(named: "9"),
    UIImage(named: "10"),
    UIImage(named: "11"),
    UIImage(named: "12"),
    UIImage(named: "13"),
    UIImage(named: "14"),
    UIImage(named: "15"),
    ]
    
    
   
