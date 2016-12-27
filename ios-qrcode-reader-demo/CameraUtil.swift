//
//  CameraUtil.swift
//  ios-qrcode-reader-demo
//
//  Created by Eiji Kushida on 2016/12/27.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit
import AVFoundation

protocol QRCodeDelegate {
    func notificationUrl(url: URL)
}

final class CameraUtil: NSObject {

    var delegate: QRCodeDelegate?

    func findDevice(position: AVCaptureDevicePosition) -> AVCaptureDevice? {

        return AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera,
                                             mediaType: AVMediaTypeVideo,
                                             position: position)
    }

    func createView(session: AVCaptureSession?,
                    device: AVCaptureDevice?) -> AVCaptureVideoPreviewLayer?{

        let videoInput = try! AVCaptureDeviceInput.init(device: device)

        if let _ = session?.canAddInput(videoInput) {
            session?.addInput(videoInput)
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if let _ = session?.canAddOutput(metadataOutput) {

            session?.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self,
                                                      queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        }

        return AVCaptureVideoPreviewLayer.init(session: session)
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension CameraUtil: AVCaptureMetadataOutputObjectsDelegate {

    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputMetadataObjects metadataObjects: [Any]!,
                       from connection: AVCaptureConnection!) {

        if metadataObjects.count > 0 {
            let qrData = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

            print("\(qrData.type)")
            print("\(qrData.stringValue)")

            if let urlString = qrData.stringValue, let url = URL(string: urlString) {
                delegate?.notificationUrl(url: url)
            }
        }
    }
}
