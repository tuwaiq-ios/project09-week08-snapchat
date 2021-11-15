
//  ViewController.swift
//  tiktok
//
//  Created by sara saud on 11/15/21.
//

import UIKit
struct VideoModel {
    let caption: String
    let username: String
    let audioTrackName: String
    let videoFileName: String
   let videoFileFormat: String
}
class TikTok: UIViewController {
    
    private var collectionView: UICollectionView?

        private var data = [VideoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
        
        for _ in 0..<1{
            let model = VideoModel(caption: "Abyat AD",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 🎵",
                                   videoFileName: "video",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        for _ in 1..<2 {
            let model = VideoModel(caption: "Expo 2020 Dubai ",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 🎵",
                                   videoFileName: "video2",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        for _ in 2..<3 {
            let model = VideoModel(caption: "Abyat AD",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 🎵",
                                   videoFileName: "video3",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        for _ in 3..<4 {
            let model = VideoModel(caption: "food AD",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 🎵",
                                   videoFileName: "video4",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        for _ in 4..<5 {
            let model = VideoModel(caption: "Abyat AD",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 🎵",
                                   videoFileName: "video5",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        for _ in 5..<6 {
            let model = VideoModel(caption: "Abyat AD",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 🎵",
                                   videoFileName: "video6",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        for _ in 6..<7 {
            let model = VideoModel(caption: "Abyat AD",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 🎵",
                                   videoFileName: "video7",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        for _ in 7..<8 {
            let model = VideoModel(caption: "Abyat AD",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 🎵",
                                   videoFileName: "video8",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        for _ in 8..<9 {
            let model = VideoModel(caption: "Abyat AD",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 🎵",
                                   videoFileName: "video9",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        
    let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width,
                                 height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.isPrefetchingEnabled = true
        collectionView?.register(VideoCollectionViewCell.self,
                                 forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
    }
    override func viewDidLayoutSubviews () {
        super.viewDidLayoutSubviews ()
        collectionView? .frame = view.bounds
    }
    
}

extension TikTok: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    

       
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
            UICollectionViewCell {
            let model = data[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier,
                                                               for: indexPath) as! VideoCollectionViewCell
            cell.configure(with: model)
                cell.delegate = self
            return cell
}
}

extension TikTok: VideoCollectionViewCellDelegate{
    func didTapLikeButton(with model: VideoModel) {
        print("like button tapped")
    }
    
    func didTapProfileButton(with model: VideoModel) {
        print("profile button tapped")

    }
    
    func didTapShareButton(with model: VideoModel) {
        print("share button tapped")

    }
    
    func didTapCommentButton(with model: VideoModel) {
        print("comment button tapped")

    }
    
    
}
