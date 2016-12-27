//
//  ViewController.swift
//  ios-qrcode-reader-demo
//
//  Created by Eiji Kushida on 2016/12/27.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit
import AVFoundation
import SafariServices

class ViewController: UIViewController {

    let session = AVCaptureSession()
    let camera = CameraUtil()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCameraView()
        session.startRunning()
    }

    private func setupCameraView() {

        camera.delegate = self

        guard let device = camera.findDevice(position: .back) else {
            fatalError("シュミレーターは、使えません")
        }

        if let videoLayer = camera.createView(session: session, device: device) {

            videoLayer.frame = self.view.bounds
            videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.view.layer.addSublayer(videoLayer)
        } else {
            fatalError("VideoLayerがNil")
        }
    }
}

//MARK:- QRCodeDelegate
extension ViewController: QRCodeDelegate {

    func notificationUrl(url: URL) {

        let vc = SFSafariViewController(url: url)
        present(vc, animated: false, completion: nil)
    }
}

