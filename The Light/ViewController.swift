//
//  ViewController.swift
//  The Light
//
//  Created by Vasily Churbanov on 2021-01-27.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    var isLightOn = true
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        updateUI()
    }

    fileprivate func updateUI() {
        view.backgroundColor = isLightOn ? .white : .black
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isLightOn.toggle()
        updateUI()
        switchFlash(isOn: isLightOn)
        doHaptic()
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
    
    
    fileprivate func doHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    
    
}

