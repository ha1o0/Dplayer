//
//  ViewController.swift
//  Dplayer
//
//  Created by sidney on 03/29/2021.
//  Copyright (c) 2021 sidney. All rights reserved.
//

import UIKit
import Dplayer
import AVFoundation
import AVKit
import MediaPlayer

class ViewController: UIViewController, DplayerDelegate {

    var videos = ["https://blog.iword.win/langjie.mp4", "http://192.168.6.242/2.mp4", "https://blog.iword.win/5.mp4", "http://192.168.6.242/3.wmv", "http://192.168.6.242/mjpg.avi", "https://iqiyi.cdn9-okzy.com/20201104/17638_8f3022ce/index.m3u8"]
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.height
    var diyPlayerView = DplayerView()
    var pipController: AVPictureInPictureController?
    var vc :UIViewController?
    var popForPip = false
    var video: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = SCREEN_WIDTH / 16 * 9
        diyPlayerView = DplayerView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: height))
        diyPlayerView.layer.zPosition = 999
        diyPlayerView.delegate = self
        diyPlayerView.bottomProgressBarViewColor = UIColor.red
        view.addSubview(diyPlayerView)
        if self.video["url"] == nil {
            self.video["url"] = videos[1]
        }

        let videoProgress = self.video["progress"] ?? "0"
        if let url = self.video["url"] {
            diyPlayerView.playUrl(url: url, progress: Float(videoProgress) ?? 0.0)
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.popForPip {
            return
        }
        self.diyPlayerView.closePlayer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func fullScreen() {
        appDelegate.deviceOrientation = .landscapeRight
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    func exitFullScreen() {
        appDelegate.deviceOrientation = .portrait
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    func pip() {
        pipController = self.diyPlayerView.getPipVc()
        pipController?.delegate = self
        self.diyPlayerView.startPip(pipController)
    }
    
    func playing(progress: Float, url: String) {
        Storage.pipVideo["progress"] = "\(progress)"
        Storage.pipVideo["url"] = url
    }

}

extension ViewController: AVPictureInPictureControllerDelegate {
    // 保持当前VC不被销毁
    func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        self.vc = self
        self.popForPip = true
        self.navigationController?.popViewController(animated: true)
    }

    // 销毁原VC，push新VC
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        self.vc = nil
        print("pictureInPictureControllerDidStopPictureInPicture")
    }
    
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        let newVc = ViewController()
        newVc.video = Storage.pipVideo
        appDelegate.rootVc.navigationController?.pushViewController(newVc, animated: true)
        print("pictureInPictureControllerDidStopPictureInPicture")
    }
}
