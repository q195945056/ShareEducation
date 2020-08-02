//
//  PlayerViewController.swift
//  ShareEducation
//
//  Created by 严明俊 on 2019/12/3.
//  Copyright © 2019 严明俊. All rights reserved.
//

import UIKit
#if DEBUG
#else
import IJKMediaFramework
#endif

class PlayerViewController: UIViewController {
    
    @IBOutlet var courseView: UIView!
            
    @IBOutlet var navigationView: UIView!
    
    @IBOutlet var playControlView: UIView!
    
    @IBOutlet var currentTimeLabel: UILabel!
    
    @IBOutlet var totalTimeLabel: UILabel!
    
    @IBOutlet var backwardButton: UIButton!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var forwardButton: UIButton!
    
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var orientationButton: UIButton!
        
    var urlString: String?
    
    #if DEBUG
    #else
    lazy var coursePlayer = IJKFFMoviePlayerController(contentURLString: urlString, with: nil).then {
        $0.scalingMode = .aspectFit
        $0.shouldAutoplay = true
    }
    #endif

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func prepareToPlay() {
        setupUI()
        installMovieNotificationObservers()
        #if DEBUG
        #else
        coursePlayer.prepareToPlay()
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if urlString != nil {
            #if DEBUG
            #else
            coursePlayer.shutdown()
            #endif
        }
        removeMovieNotificationObservers()
    }
    
    func setupUI() {
        traitCollectionDidChange(nil)
        #if DEBUG
        #else
        courseView.addSubview(coursePlayer.view)
        coursePlayer.view.snp.makeConstraints { (make) in
            make.edges.equalTo(courseView)
        }
        #endif
        
    }
    
    func installMovieNotificationObservers() {
        #if DEBUG
        #else
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(mediaIsPreparedToPlayDidChange(_:)), name: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange, object: coursePlayer)
        notificationCenter.addObserver(self, selector: #selector(mediaPlaybackStateDidChange(_:)), name: NSNotification.Name.IJKMPMoviePlayerPlaybackStateDidChange, object: coursePlayer)
        #endif
    }
    
    func removeMovieNotificationObservers() {
        #if DEBUG
        #else
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange, object: coursePlayer)
        #endif
    }

    
    // MARK: - Actions
    
    @objc func mediaIsPreparedToPlayDidChange(_ notification: Notification) {
        #if DEBUG
        #else
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
        #endif
        
    }
    
    @objc func mediaPlaybackStateDidChange(_ notification: Notification) {
        #if DEBUG
        #else
        switch coursePlayer.playbackState {
        case .playing:
            playButton.setImage(UIImage(named: "icon_play"), for: .normal)
        default:
            playButton.setImage(UIImage(named: "icon_play2"), for: .normal)
        }
        #endif
    }
    
    @IBAction func onBackGroundTapped(_ sender: UITapGestureRecognizer) {
        navigationView.alpha = navigationView.alpha == 0 ? 1 : 0
        playControlView.alpha = playControlView.alpha == 0 ? 1 : 0
    }
    
    @IBAction func backWard(_ sender: UIButton) {
        #if DEBUG
        #else
        coursePlayer.currentPlaybackTime -= 5
        #endif
    }
    
    @IBAction func forwad(_ sender: UIButton) {
        #if DEBUG
        #else
        coursePlayer.currentPlaybackTime += 5
        #endif
    }
    
    @IBAction func play(_ sender: UIButton) {
        #if DEBUG
        #else
        if coursePlayer.playbackState == .playing {
            coursePlayer.pause()
        } else {
            coursePlayer.play()
        }
        #endif
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
