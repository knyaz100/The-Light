//
//  ViewController.swift
//  The Light
//
//  Created by Vasily Churbanov on 2021-01-27.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    //MARK: Constants & Varables
    var isLightOn = false
        
    //MARK: Overriden methods
    
    /// Hiding status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        updateUI()
    }
    
    /// Hander for user touch the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isLightOn.toggle()
        updateUI()
        switchTorch(isOn: isLightOn)
        doHaptic()
    }
    
    //MARK: Private methods
    
    /// Change screen color
    fileprivate func updateUI() {
        view.backgroundColor = isLightOn ? .white : .black
    }
    
    /// Switch torch on/off
    /// - Parameter isOn: Torch on/off flag
    fileprivate func switchTorch(isOn: Bool) {
        
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
            return
        }
        
        guard device.hasTorch else {
            return
        }
        
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
        
    /// Generate haptic feedback
    fileprivate func doHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
