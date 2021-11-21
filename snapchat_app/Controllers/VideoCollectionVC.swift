//
//  VideoCollectionVC.swift
//  snapchat_app
//
//  Created by dmdm on 20/11/2021.
//

import UIKit
import AVFoundation

protocol VideoCollectionViewDelegate: AnyObject{
    func didTapLikeButton(with model: VideoModel)
    func didTapprofieButton(with model: VideoModel)
    func didTapshareButton(with model: VideoModel)
    func didTapcommentButton(with model: VideoModel)
}

class VideoCollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewController"
    
    //Labels
    private let  audiolabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private let  captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let  usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    // Buttons
    private let profieButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        return button
        //        button.backgroundColor = .white
        
        
    } ()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        //        button.backgroundColor = .white
        
        return button
        
    } ()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
        //        button.backgroundColor = .white
        return button
        
    } ()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrowshape.trun.up.right.fill"), for: .normal)
        //        button.backgroundColor = .white
        
        return button
        
    } ()
    private let videoContainer = UIView()
    
    // delegate
    
    weak var delegate : VideoCollectionViewCell?
    //Subview
    var player: AVPlayer?
    private var model : VideoModel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        addSubview()
    }
    private func addSubview() {
        
        contentView.addSubview(videoContainer)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(audiolabel)
        
        contentView.addSubview(profieButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        //add action
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
        profieButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchDown)
        commentButton.addTarget(self, action: #selector(didTapcommentButton), for: .touchDown)
        shareButton.addTarget(self, action: #selector(didTapshareButton), for: .touchDown)
        videoContainer.clipsToBounds = true
        contentView.sendSubviewToBack(videoContainer)
        //        likeButton.imageView?.tintColor = .black
    }
    @objc private func didTapLikeButton() {
        guard let model = model else {return}
        //      delegate?.didTapLikeButton(with: VideoModel)
    }
    @objc private func didTapProfileButton() {
        guard let model = model else {return}
        //        delegate?.didTapProfileButton(with: model)
    }
    @objc private func didTapcommentButton() {
        guard let model = model else {return}
        //        delegate?.didTapcommentButton(with: model)
    }
    @objc private func didTapshareButton() {
        guard let model = model
        else {
            return
            
        }
        //        delegate?.didTapshareButton(with: model)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        videoContainer.frame = contentView.bounds
        let size  = contentView.frame.size.width/7
        let width  = contentView.frame.size.width
        let height  = contentView.frame.size.height - 100
        //        Buttons
        // shareButton.backgroundColor = .red
        shareButton.frame = CGRect(x: width-size, y:height-(size*1)-10, width: size, height: size)
        commentButton.frame = CGRect(x: width-size, y:height-(size*2)-10 , width: size, height: size)
        likeButton.frame = CGRect(x: width-size, y:height-(size*3)-10 , width: size, height: size)
        profieButton.frame = CGRect(x: width-size, y:height-(size*4)-10 , width: size, height: size)
        
        
        
        //labels
        //username.caption.audio
        audiolabel.frame = CGRect(x: 5, y: height-50, width: width-size-20, height: 50)
        usernameLabel.frame = CGRect(x: 5, y: height-80, width: width-size-10, height: 50)
        captionLabel.frame = CGRect(x: 5, y: height-120, width: width-size-10, height: 50)
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text = nil
        audiolabel.text = nil
        usernameLabel.text = nil
    }
    
    public  func configure(with model: VideoModel) {
        self.model = model
        configureVideo()
        //lables
        captionLabel.text = model.caption
        audiolabel.text = model.audioTrackName
        usernameLabel.text = model.user
        
    }
    private func  configureVideo() {
        guard let model = model else {
            return
        }
        
        guard let path = Bundle.main.path(forResource: model.VideoFileName,
                                          ofType: model.VideoFileFromat) else {
            return
            
        }
        player = AVPlayer (url: URL(fileURLWithPath: path))
        
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        //    contentView.layer
        videoContainer.layer.addSublayer(playerView)
        player?.volume = 0
        player? .play()
        contentView.backgroundColor = .black
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
