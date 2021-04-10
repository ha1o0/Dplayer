//
//  ViewController.swift
//  Dplayer
//
//  Created by sidney on 03/29/2021.
//  Copyright (c) 2021 sidney. All rights reserved.
//

import UIKit
import Dplayer

@available(iOS 13.0, *)
class ViewController: UIViewController, DplayerDelegate {

    var videos = ["https://blog.iword.win/langjie.mp4", "http://192.168.6.242/2.mp4", "https://blog.iword.win/5.mp4", "http://192.168.6.242/3.wmv", "http://192.168.6.242/mjpg.avi", "https://iqiyi.cdn9-okzy.com/20201104/17638_8f3022ce/index.m3u8"]
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = SCREEN_WIDTH / 16 * 9
        var diyPlayerView = DplayerView()
        diyPlayerView = DplayerView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: height))
        diyPlayerView.layer.zPosition = 999
        diyPlayerView.delegate = self
        view.addSubview(diyPlayerView)
//        diyPlayerView.snp.makeConstraints { (maker) in
//            maker.leading.trailing.equalToSuperview()
//            maker.top.equalToSuperview().offset(100)
//            maker.height.equalTo(height)
//        }
        diyPlayerView.commonInit()
        diyPlayerView.playUrl(url: videos[0])
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}

