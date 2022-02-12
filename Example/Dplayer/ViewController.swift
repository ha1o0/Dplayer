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

    var videos = [
        "https://blog.iword.win/langjie.mp4",
        "http://192.168.6.242/langjie.mp4",
        "https://blog.iword.win/5.mp4",
        "http://192.168.6.242/2.mp4",
        "http://192.168.6.242/3.wmv",
        "http://192.168.6.242/mjpg.avi",
        "https://iqiyi.cdn9-okzy.com/20201104/17638_8f3022ce/index.m3u8",
        "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8",
        "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"
    ]
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
        diyPlayerView = DplayerView(frame: CGRect(x: 0, y: 44, width: SCREEN_WIDTH, height: height))
        diyPlayerView.layer.zPosition = 999
        diyPlayerView.delegate = self
        diyPlayerView.bottomProgressBarViewColor = UIColor.red
        view.addSubview(diyPlayerView)
        self.playVideo()
        appDelegate.currentPlayer = diyPlayerView.player
        appDelegate.currentPlayerLayer = diyPlayerView.playerLayer
        let playBtn = UIButton()
        playBtn.setTitle("播放", for: .normal)
        self.view.addSubview(playBtn)
        playBtn.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        playBtn.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        
        let sendSelfDamuBtn = UIButton()
        sendSelfDamuBtn.setTitle("模拟发送自己的弹幕", for: .normal)
        sendSelfDamuBtn.tag = 1
        self.view.addSubview(sendSelfDamuBtn)
        sendSelfDamuBtn.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(playBtn.snp.bottom).offset(20)
        }
        sendSelfDamuBtn.addTarget(self, action: #selector(sendDanmu(button:)), for: .touchUpInside)
        
        let sendOtherDanmuBtn = UIButton()
        sendOtherDanmuBtn.tag = 2
        sendOtherDanmuBtn.setTitle("模拟接收别人发送的弹幕", for: .normal)
        self.view.addSubview(sendOtherDanmuBtn)
        sendOtherDanmuBtn.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(sendSelfDamuBtn.snp.bottom).offset(20)
        }
        sendOtherDanmuBtn.addTarget(self, action: #selector(sendDanmu(button:)), for: .touchUpInside)
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

    @objc func playVideo() {
        if self.video["url"] == nil {
            self.video["url"] = videos[3]
        }

        let videoProgress = self.video["progress"] ?? "0"
        if let url = self.video["url"] {
            diyPlayerView.playUrl(url: url, progress: Float(videoProgress) ?? 0.0)
        }
    }
    
    func beforeFullScreen() {
        self.diyPlayerView.danmu.danmuConfig.speed = 896.0 / 8.0
        self.diyPlayerView.danmu.danmuConfig.maxChannelNumber = 15
    }
    
    func fullScreen() {

    }
    
    func beforeExitFullScreen() {
        self.diyPlayerView.danmu.danmuConfig.speed = 414.0 / 8.0
        self.diyPlayerView.danmu.danmuConfig.maxChannelNumber = 8
    }
    
    func exitFullScreen() {
        
    }
    
    /// 视频准备播放时的代理
    func readyToPlay(totalTimeSeconds: Float) {
//        var danmus: [DanmuModel] = []
//        let colors: [UIColor] = [.white, .yellow, .red, .blue, .green]
//        let fontSizes: [CGFloat] = [17.0, 14.0]
//        for i in 0..<3000 {
//            var danmu = DanmuModel()
//            danmu.id = "\(i + 1)"
//            danmu.time = Float(arc4random() % UInt32(totalTimeSeconds)) + (Float(arc4random() % UInt32(9)) / 10)
//            danmu.content = "第\(danmu.time)秒弹幕"
//            danmu.color = colors[Int(arc4random() % UInt32(5))].withAlphaComponent(0.7)
//            danmu.fontSize = fontSizes[Int(arc4random() % UInt32(2))]
//            if i % 500 == 0 {
//                danmu.isSelf = true
//            }
//            danmus.append(danmu)
//        }
//        var danmuConfig = DanmuConfig()
//        danmuConfig.maxChannelNumber = 8
////        danmuConfig.mode = DanmuMode.live
//        self.diyPlayerView.danmu.danmus = danmus
//        self.diyPlayerView.danmu.danmuConfig = danmuConfig
    }
    
    @objc func sendDanmu(button: UIButton) {
        var danmu = DanmuModel()
        danmu.isSelf = button.tag == 1
        danmu.content = "发送了一条弹幕"
        // 发送弹幕到服务器后呈现在播放器中
        self.diyPlayerView.danmu.sendDanmu(danmu: &danmu)
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
    
    deinit {
        print("deinit")
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
