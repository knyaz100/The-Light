//
//  ViewController.swift
//  The Light
//
//  Created by Vasily Churbanov on 2021-01-27.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    var isLightOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        updateUI()
    }

    fileprivate func updateUI() {
        view.backgroundColor = isLightOn ? .white : .black
    }
    
    fileprivate func switchFlash(isOn: Bool) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            if (!isOn) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    @IBAction func buttonPressed() {
        
        isLightOn.toggle()
        updateUI()
        switchFlash(isOn: isLightOn)
        
    }
    
    
}

