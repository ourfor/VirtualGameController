//
//  XboxViewController.swift
//  Peripheral_iOS
//
//  Created by 赫拉 on 2023/10/29.
//  Copyright © 2023 Rob Reuss. All rights reserved.
//

import Foundation
import UIKit
import VirtualGameController

class XboxViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let superview = self.view!
        let leftThumbStickView = VgcStick(frame: CGRectMake(0, 0, 120, 120), xElement: VgcManager.elements.dpadXAxis, yElement: VgcManager.elements.dpadYAxis)
        leftThumbStickView.controlView.backgroundColor = UIColor(red: 0.82, green: 0.9, blue: 0.65, alpha: 1)
        leftThumbStickView.controlView.layer.borderWidth = 2;
        leftThumbStickView.controlView.layer.borderColor = UIColor.black.cgColor
        leftThumbStickView.controlView.backgroundColor = UIColor(red: 0.82, green: 0.9, blue: 0.65, alpha: 1)
        superview.addSubview(leftThumbStickView)
        leftThumbStickView.snp.remakeConstraints { make in
            make.centerX.equalTo(superview).multipliedBy(0.5)
            make.centerY.equalTo(superview)
                .multipliedBy(0.75)
            make.size.equalTo(120)
        }
        
        let rightThumbStickView = VgcStick(frame: CGRectMake(0, 0, 120, 120), xElement: VgcManager.elements.dpadXAxis, yElement: VgcManager.elements.dpadYAxis)
        rightThumbStickView.controlView.layer.borderWidth = 2;
        rightThumbStickView.controlView.layer.borderColor = UIColor.black.cgColor
        rightThumbStickView.controlView.backgroundColor = UIColor(red: 0.81, green: 0.7, blue: 0.98, alpha: 1)
        superview.addSubview(rightThumbStickView)
        rightThumbStickView.snp.remakeConstraints { make in
            make.centerX.equalTo(superview).multipliedBy(1.5)
            make.centerY.equalTo(superview)
                .multipliedBy(1.5)
            make.size.equalTo(120)
        }
        
        let abxyView = VgcAbxyButtonPad(frame: CGRectMake(0, 0, 160, 160))
        superview.addSubview(abxyView)
        abxyView.backgroundColor = UIColor.clear
        abxyView.aButton.backgroundColor = UIColor.green
        abxyView.aButton.nameLabel.text = nil
        abxyView.bButton.nameLabel.text = nil
        abxyView.xButton.nameLabel.text = nil
        abxyView.yButton.nameLabel.text = nil
        abxyView.aButton.baseGrayShade = 1
        abxyView.bButton.baseGrayShade = 1
        abxyView.xButton.baseGrayShade = 1
        abxyView.yButton.baseGrayShade = 1
        abxyView.aButton.setBackgroundImage(UIImage(named: "button/a"), for: UIControl.State.normal)
        abxyView.aButton.setBackgroundImage(UIImage(named: "button/a_selected"), for: UIControl.State.highlighted)
        abxyView.bButton.setImage(UIImage(named: "button/b"), for: UIControl.State.normal)
        abxyView.bButton.setImage(UIImage(named: "button/b_selected"), for: UIControl.State.highlighted)
        abxyView.xButton.setImage(UIImage(named: "button/x"), for: UIControl.State.normal)
        abxyView.xButton.setImage(UIImage(named: "button/x_selected"), for: UIControl.State.highlighted)
        abxyView.yButton.setImage(UIImage(named: "button/y"), for: UIControl.State.normal)
        abxyView.yButton.setImage(UIImage(named: "button/y_selected"), for: UIControl.State.highlighted)
        abxyView.snp.remakeConstraints { make in
            make.centerX.equalTo(superview).multipliedBy(1.75)
            make.centerY.equalTo(superview)
                .multipliedBy(0.75)
            make.size.equalTo(160)
        }
    }
}
