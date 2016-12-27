# ios10-qrcode-reader-demo
iOS10のQRコードリーダーのサンプル

|category | Version| 
|---|---|
| Swift | 3.0.2 |
| XCode | 8.2 |
| iOS | 10.0〜 |

#### 備忘録
1. AVFoundation.frameworkを追加する
2. SafariServices.frameworkを追加する
3. Info.plistにNSCameraUsageDescriptionを追加する

```
    <key>NSCameraUsageDescription</key>
    <string>カメラへアクセスするために必要です</string>
```
