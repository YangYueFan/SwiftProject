
//  ViewController.swift
//  Swift_Project6_Compass
//
//  Created by 科技部2 on 2017/9/29.
//  Copyright © 2017年 Ken. All rights reserved.
//

import UIKit

import CoreLocation
import Photos
import AVFoundation
import MobileCoreServices       //用于 kUTTypeMovie  需要导入库MobileCoreServices.framework


class ViewController: UIViewController ,CLLocationManagerDelegate,
UIImagePickerControllerDelegate,UINavigationControllerDelegate,
AVCaptureFileOutputRecordingDelegate{
    
    @IBOutlet weak var bgView: UIView!
    //经度
    @IBOutlet weak var label1: UILabel!
    //维度
    @IBOutlet weak var label2: UILabel!
    //速度
    @IBOutlet weak var label3: UILabel!
    //海拔
    @IBOutlet weak var label4: UILabel!

    @IBOutlet weak var compassView: UIImageView!

    @IBOutlet weak var videoPlayBtn: UIButton!
    
    @IBOutlet weak var libraryBtn: UIButton!
    
    var locationM = CLLocationManager.init()
    
    var pickCtl = UIImagePickerController()
    
    
    //视频捕获会话。input和output的桥梁, 协调input到output的数据传输
    let captureSession = AVCaptureSession()
    //视频输入设备
    let videoDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    //音频输入设备
    let audioDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
    
    //将捕获的视频输出到文件
    let fileOutput = AVCaptureMovieFileOutput()
    //是否录制中
    var isPlaying = false
    
    var videoLayer = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationM.delegate = self
        
        locationM.startUpdatingHeading()
        
        
        locationM.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationM.distanceFilter = 10;
        //发送授权申请
        locationM.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationM.startUpdatingLocation()
        }
        
        videoInit()
        
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    
    func handleDeviceOrientationDidChange(interfaceOrientation:UIInterfaceOrientation) {
        
        
        self.videoLayer.frame = self.view.bounds
        let output2VideoConnection = fileOutput.connection(withMediaType: AVMediaTypeVideo)
        output2VideoConnection?.videoOrientation = videoOrientationFromCurrentDeviceOrientation()
        videoLayer.connection.videoOrientation = videoOrientationFromCurrentDeviceOrientation()
        if !isPlaying{

        }
        
    }
    
    
    func videoInit()  {
        
        //添加视频音频输入设备
        let videoInput = try! AVCaptureDeviceInput(device: self.videoDevice)
        self.captureSession.addInput(videoInput)
        
        let audioInput = try! AVCaptureDeviceInput(device: self.audioDevice)
        self.captureSession .addInput(audioInput)
        
        //添加视频捕获输出
        self.captureSession.addOutput(self.fileOutput)
        
        //使用AVCaptureVideoPreviewLayer可以将摄像头的拍摄的实时画面显示在ViewController上
        videoLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        videoLayer.frame = self.view.bounds
        videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        bgView.layer.insertSublayer(videoLayer, at: 0)
        
        let output2VideoConnection = fileOutput.connection(withMediaType: AVMediaTypeVideo)
        output2VideoConnection?.videoOrientation = videoOrientationFromCurrentDeviceOrientation()
        
        videoLayer.connection.videoOrientation =  videoOrientationFromCurrentDeviceOrientation()
        self.captureSession.startRunning()
    }

    func videoOrientationFromCurrentDeviceOrientation() -> AVCaptureVideoOrientation {

        let device = UIDevice.current
        switch device.orientation {
        case .portraitUpsideDown:
            return AVCaptureVideoOrientation.portraitUpsideDown
        case .landscapeLeft:
            return AVCaptureVideoOrientation.landscapeRight
        case .landscapeRight:
            return AVCaptureVideoOrientation.landscapeLeft
        default:
            return AVCaptureVideoOrientation.portrait
        }
    }
    
    //指南针
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        if newHeading.headingAccuracy < 0 {
            return
        }
        
        let angle = newHeading.magneticHeading
        
        let radius = angle / 180.0 * M_PI
        
        UIView.animate(withDuration: 0.25) { 
            self.compassView.transform = CGAffineTransform.init(rotationAngle: CGFloat(-radius))
        }
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        label1.text = String.init(format: "%lf",(currentLocation?.coordinate.latitude)!, 1)
        label2.text = String.init(format: "%lf",(currentLocation?.coordinate.longitude)!,1)
        label3.text = String.init(format: "%0.2f",(currentLocation?.speed)! ,1)
        label4.text = String.init(format: "%0.2f",(currentLocation?.altitude)!,1)
    }

    
    
    @IBAction func playAction(_ sender: UIButton) {
    
        sender.isSelected = !sender.isSelected
        self.isPlaying = sender.isSelected
        if sender.isSelected == true{
            //设置录像的保存地址（在Documents目录下，mp4）
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0] as String
            
            let filePath : String? = "\(documentsDirectory)/Ken\(NSDate().timeIntervalSince1970).mp4"
            let fileURL : NSURL = NSURL(fileURLWithPath: filePath!)
            //启动视频编码输出
            fileOutput.startRecording(toOutputFileURL: fileURL as URL!, recordingDelegate: self)
            
            
        }else{
           fileOutput.stopRecording()
        }
    }
    
    
    //录像开始的代理方法
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        self.libraryBtn.isHidden = true
        NSLog("开始录制", 1)
        
    }
    //录像结束的代理方法
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        NSLog("结束录制", 1)
        PHPhotoLibrary.shared().performChanges({ 
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputFileURL)
            
        }) { (isSuccess, error) in
            if error != nil {
                NSLog("\(String(describing: error))", 1)
            }else{
                let alertCtl = UIAlertController.init(title: "保存成功", message: nil, preferredStyle: .alert)
                let action1 = UIAlertAction.init(title: "确定", style: .default, handler: nil)
                alertCtl.addAction(action1)
                self.present(alertCtl, animated: true, completion: nil )
            }
            
            self.libraryBtn.isHidden = false
        }
        
    }
    
    @IBAction func goLibraryAction(_ sender: UIButton) {
        imagePickerInit()
    }
    
    
    func imagePickerInit()  {

        let isEnable = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)

        if isEnable == true {

            pickCtl.sourceType = .photoLibrary
            pickCtl.mediaTypes = [kUTTypeMovie as String]
            pickCtl.delegate = self

            pickCtl.view.frame = self.view.bounds

            self.present(pickCtl, animated: true, completion: { 
                self.captureSession.stopRunning()
            })
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.captureSession.isRunning == false {
            self.captureSession.startRunning()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

