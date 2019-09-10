//
//  QRCodeScanVC.swift
//  Bilieto
//
//  Created by Amisha on 4/4/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox


class QRCodeScanVC: UIViewController,AVCaptureMetadataOutputObjectsDelegate  {

    @IBOutlet weak var codescanView: UIView!
    
    var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var captureSession:AVCaptureSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dropDownSelection(noti:)), name: NSNotification.Name(rawValue: "DROPDOWN_SELECTION"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToScanQRCode(noti:)), name: NSNotification.Name(rawValue: "SCAN_QRCODE"), object: nil)
        
       capture()
       
    }
    
    let codeFrame:UIView = {
        let codeFrame = UIView()
        codeFrame.layer.borderColor = UIColor.green.cgColor
        codeFrame.layer.borderWidth = 2
        codeFrame.frame = CGRect.zero
        codeFrame.translatesAutoresizingMaskIntoConstraints = false
        return codeFrame
    }()
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            //print("No Input Detected")
            codeFrame.frame = CGRect.zero
            self.view.makeToast("No Data", duration: 3.0, position: .bottom)
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        guard let stringCodeValue = metadataObject.stringValue else { return }
        
        view.addSubview(codeFrame)
        
        guard let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        codeFrame.frame = barcodeObject.bounds
        
        // Play system sound with custom mp3 file
        if let customSoundUrl = Bundle.main.url(forResource: "Beep", withExtension: "mp3") {
            var customSoundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
            //let systemSoundId: SystemSoundID = 1016  // to play apple's built in sound, no need for upper 3 lines
            
            AudioServicesAddSystemSoundCompletion(customSoundId, nil, nil, { (customSoundId, _) -> Void in
                AudioServicesDisposeSystemSoundID(customSoundId)
            }, nil)
            
            AudioServicesPlaySystemSound(customSoundId)
        }
        
        // Stop capturing and hence stop executing metadataOutput function over and over again
        captureSession?.stopRunning()
        
        self.videoPreviewLayer?.removeFromSuperlayer()
        codeFrame.removeFromSuperview()
        self.view.makeToast("Scanned:\(stringCodeValue)", duration: 3.0, position: .bottom)
        
        //store to userdefault
        let finalString = String(describing: Date()) + "<==>" + stringCodeValue
        if let arr = UserDefaults.standard.object(forKey: "history") as? [String] {
            let aryStr = NSMutableArray(array: arr)
            aryStr.add(finalString)
            UserDefaults.standard.set(aryStr, forKey: "history")
        }else{
            UserDefaults.standard.set([finalString], forKey: "history")
        }
    }
    func capture()  {
        captureDevice = AVCaptureDevice.default(for: .video)
        // Check if captureDevice returns a value and unwrap it
        if let captureDevice = captureDevice {
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession = AVCaptureSession()
                guard let captureSession = captureSession else { return }
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39, .aztec, .code39Mod43, .code93, .dataMatrix, .face]
                
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                codescanView.layer.addSublayer(videoPreviewLayer!)
                
            } catch {
                print("Error Device Input")
            }
        }
    }
    
    @IBAction func ClickToMyCode(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
   
    @objc func dropDownSelection(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is QRCodeScanVC) {
            let dict : [String : Int] = noti.object as! [String : Int]
            if let index : Int = dict["index"]
            {
                if index == 0
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else if index == 1
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "ChangeStyleVC") as! ChangeStyleVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else if index == 2
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "OptionsVC") as! OptionsVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else if index == 3
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else {
                    AppDelegate().sharedDelegate().logout()
                }
            }
        }
    }
    
    
    @objc func redirectToScanQRCode(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is QRCodeScanVC) {
            let vc : MyQRCodeVC = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
