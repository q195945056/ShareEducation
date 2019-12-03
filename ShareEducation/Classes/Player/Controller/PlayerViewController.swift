//
//  PlayerViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/3.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
import IJKMediaFramework

class PlayerViewController: UIViewController {
    
    @IBOutlet var courseView: UIView!
    
    @IBOutlet var teacherView: UIView!
    
    @IBOutlet var commentView: UIView!
    
    @IBOutlet var navigationView: UIView!
    
    @IBOutlet var playControlView: UIView!
    
    @IBOutlet var currentTimeLabel: UILabel!
    
    @IBOutlet var totalTimeLabel: UILabel!
    
    @IBOutlet var backwardButton: UIButton!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var forwardButton: UIButton!
    
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var orientationButton: UIButton!
    
    var urlString = "http://220.161.87.62:8800/hls/0/index.m3u8"
    
    lazy var coursePlayer = IJKAVMoviePlayerController(contentURLString: urlString).then {
        $0.scalingMode = .aspectFit
        $0.shouldAutoplay = true
    }
    
    lazy var teacherPlayer = IJKAVMoviePlayerController(contentURLString: urlString).then {
        $0.scalingMode = .aspectFill
        $0.shouldAutoplay = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        installMovieNotificationObservers()
        coursePlayer.prepareToPlay()
        teacherPlayer.prepareToPlay()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        coursePlayer.shutdown()
        removeMovieNotificationObservers()
    }
    
    func setupUI() {
        traitCollectionDidChange(nil)
        courseView.addSubview(coursePlayer.view)
        coursePlayer.view.snp.makeConstraints { (make) in
            make.edges.equalTo(courseView)
        }
        
        teacherView.addSubview(teacherPlayer.view)
        teacherPlayer.view.snp.makeConstraints { (make) in
            make.edges.equalTo(teacherView)
        }
    }
    
    func installMovieNotificationObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(mediaIsPreparedToPlayDidChange(_:)), name: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange, object: coursePlayer)
        notificationCenter.addObserver(self, selector: #selector(mediaPlaybackStateDidChange(_:)), name: NSNotification.Name.IJKMPMoviePlayerPlaybackStateDidChange, object: coursePlayer)
    }
    
    func removeMovieNotificationObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange, object: coursePlayer)
    }

    
    // MARK: - Actions
    
    @objc func mediaIsPreparedToPlayDidChange(_ notification: Notification) {
        let duration = coursePlayer.duration
        if duration.isNaN {
            currentTimeLabel.text = "00:00:00"
            totalTimeLabel.text = "00:00:00"
            backwardButton.isEnabled = false
            forwardButton.isEnabled = false
            slider.isEnabled = false
        } else {
            currentTimeLabel.text = "00:00:00"
            totalTimeLabel.text = "00:00:00"
            backwardButton.isEnabled = true
            forwardButton.isEnabled = true
            slider.isEnabled = true
        }
    }
    
    @objc func mediaPlaybackStateDidChange(_ notification: Notification) {
        switch coursePlayer.playbackState {
        case .playing:
            playButton.setImage(UIImage(named: "icon_play"), for: .normal)
        default:
            playButton.setImage(UIImage(named: "icon_play2"), for: .normal)
        }
    }
    
    @IBAction func onBackGroundTapped(_ sender: UITapGestureRecognizer) {
        navigationView.alpha = navigationView.alpha == 0 ? 1 : 0
        playControlView.alpha = playControlView.alpha == 0 ? 1 : 0
    }
    
    @IBAction func backWard(_ sender: UIButton) {
        coursePlayer.currentPlaybackTime -= 5
    }
    
    @IBAction func forwad(_ sender: UIButton) {
        coursePlayer.currentPlaybackTime += 5
    }
    
    @IBAction func play(_ sender: UIButton) {
        if coursePlayer.playbackState == .playing {
            coursePlayer.pause()
        } else {
            coursePlayer.play()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlayerViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass || traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
            if traitCollection.verticalSizeClass == .compact { //横屏
                navigationView.isHidden = false
            } else {
                navigationView.isHidden = true
            }
        }
    }
}
