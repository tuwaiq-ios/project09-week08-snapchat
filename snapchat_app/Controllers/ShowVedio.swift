//
//  ShowVedio.swift
//  snapchat_app
//
//  Created by dmdm on 20/11/2021.
//

import UIKit
struct VideoModel {
    let caption: String
    let user : String
    let audioTrackName : String
    let VideoFileName : String
    let VideoFileFromat : String
}
class TikTokVC : UIViewController {
    
    private  var CollectionView: UICollectionView?
    
    private var data = [VideoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<10 {
            let model = VideoModel(caption: "ABHA_SWIFT⭐️",
                                   user: "@Mohammed",
                                   audioTrackName: "MDH",
                                   VideoFileName: "RPReplay_Final1637475712",
                                   VideoFileFromat: "mov")
            //
            data.append(model)
        }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width:view.frame.size.width,
                                 height:view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        CollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        CollectionView?.register(VideoCollectionViewCell.self,
                                 forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        CollectionView?.isPagingEnabled = true
        CollectionView?.dataSource = self
        view.addSubview(CollectionView!)
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CollectionView?.frame = view.bounds
    }
    
}

extension TikTokVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  VideoCollectionViewCell.identifier, for: indexPath) as!  VideoCollectionViewCell
        cell.configure(with: model)
        return cell
    }
    
    //    override func collapseSecondaryViewController(_ secondaryViewController: UIViewController, for splitViewController: UISplitViewController) {
    
    
    
    // extension ViewController: VideoCollectionViewDelegate {
    
    func didTapLikeButton(with model: VideoModel) {
        print ("like button tapped")
    }
    
    func didTapprofieButton(with model: VideoModel) {
        print ("profie button tapped")
    }
    
    func didTapcommentButton(with model: VideoModel) {
        print ("comment button tapped")
    }
    
    func didTapshareButton(with model: VideoModel) {
        print ("share button tapped")
    }
}
