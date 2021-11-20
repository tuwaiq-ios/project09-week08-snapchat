
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
//    let isfavorit : Bool
    private var collectionView: UICollectionView?

        private var data = [VideoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        


        // Do any additional setup after loading the view.
        // abyat add
        for _ in 0..<1{
            let model = VideoModel(caption: "Abyat AD",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 🎵",
                                   videoFileName: "video",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        // exbo dubai
        for _ in 1..<2 {
            let model = VideoModel(caption: "Expo 2020 Dubai 🇦🇪 ",
                                   username: "@Amal",
                                   audioTrackName: "Video Song 🎵",
                                   videoFileName: "video2",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        //jedaah rain
        for _ in 2..<3 {
            let model = VideoModel(caption: "Rainy Day 🌧 ",
                                   username: "@Sara",
                                   audioTrackName: "Video Song2 🎵",
                                   videoFileName: "video3",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        //Cars
        for _ in 3..<4 {
            let model = VideoModel(caption: "King abdullah road ",
                                   username: "@Fawaz",
                                   audioTrackName: "Video Song 3🎵",
                                   videoFileName: "video4",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        //cake
        for _ in 4..<5 {
            let model = VideoModel(caption: "My New Own Party Cake 🍰 ",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 4 🎵",
                                   videoFileName: "video5",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        //kitchen
        for _ in 5..<6 {
            let model = VideoModel(caption: "our Today's lunch 🌮",
                                   username: "@Lolo",
                                   audioTrackName: "Video Song 5 🎵",
                                   videoFileName: "video6",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        // sea
        for _ in 6..<7 {
            let model = VideoModel(caption: "sea vacation 🌊",
                                   username: "@Sara",
                                   audioTrackName: "Video Song 6🎵",
                                   videoFileName: "video7",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        
        for _ in 7..<8{
            let model = VideoModel(caption: "indego resort",
                                   username: "@Sara",
                                   audioTrackName: "Video Song  7🎵",
                                   videoFileName: "video8",
                                   videoFileFormat: "mp4")
            data.append (model)
        }
        // hadi
        for _ in 8..<9 {
            let model = VideoModel(caption: "the best instructor Ever (HADI)®....",
                                   username: "@Sara",
                                   audioTrackName: "class 2 ",
                                   videoFileName: "video99",
                                   videoFileFormat: "MP4")
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
        print("back button tapped")
//        let button = UIButton(type: .custom)
//        let image = UIImage(named: "fav")?.withRenderingMode(.alwaysTemplate)
//        button.setImage(image, for: .normal)
//        button.tintColor = UIColor.red
        
        let vc = TabVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func didTapProfileButton(with model: VideoModel) {
        print("profile button tapped")
        let vc = MyProfileVC()
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
    }
    
    func didTapShareButton(with model: VideoModel) {
        print("share button tapped")
        
        let activityVC = UIActivityViewController(activityItems: [model.caption], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    func didTapCommentButton(with model: VideoModel) {
        let alert1 = UIAlertController(
              title: ("Report ⚠️"),message: "are you sure want to reporting this  ⁉️",preferredStyle: .alert)
        alert1.addAction(UIAlertAction(title: "im sure",style: .cancel,handler: { action in
              print("OK") } ) )
        alert1.addAction(UIAlertAction(title: "cancel",style: .default,handler: { action in
            
            print("cancel") } ))
            present(alert1, animated: true, completion: nil)
          }
    
                                           }

