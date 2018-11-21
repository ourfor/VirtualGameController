//
//  GameViewController.swift
//  SceneKitDemo
//
//  Created by Rob Reuss on 12/8/15.
//  Copyright (c) 2015 Rob Reuss. All rights reserved.
//

import QuartzCore
import SceneKit
import GameController
import VirtualGameController
#if os(iOS) || os(tvOS)
import UIKit
#endif

var ship: SCNNode!
var ship2: SCNNode!
var lightNode: SCNNode!
var cameraNode: SCNNode!
var sharedCode: SharedCode!

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VgcManager.loggerLogLevel = .Debug
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.controllerDidConnect), name: NSNotification.Name(rawValue: VgcControllerDidConnectNotification), object: nil)

        // Uncomment to run using the iOS Peripheral sample app to control the ship.  Be sure to turn Motion on through the iOS Peripheral sample app.
        VgcManager.startAs(.Central, appIdentifier: "vgc", customElements: nil, customMappings: nil, includesPeerToPeer: true, enableLocalController: false)
        
        // Uncomment to run where two iOS devices each display two ships, and using motion, each device controls one ship.  Both ships are kept in sync across both devices.
        //VgcManager.startAs(.MultiplayerPeer, appIdentifier: "vgc", customElements: nil, customMappings: nil, includesPeerToPeer: true, enableLocalController: true)
        //VgcManager.peripheral.browseForServices()
        
        VgcManager.performanceSamplingDisplayFrequency = 0
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // create and add a camera to the scene
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        // create and add a light to the scene
        lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        lightNode.eulerAngles = SCNVector3Make(0.0, 3.1415/2.0, 0.0);
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        #if os(OSX)
            ambientLightNode.light!.color = NSColor.darkGrayColor()
        #endif
        #if os(iOS) || os(tvOS)
            ambientLightNode.light!.color = UIColor.darkGray
        #endif
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        #if os(OSX)
            scnView.backgroundColor = NSColor.blackColor()
        #endif
        #if os(iOS) || os(tvOS)
            scnView.backgroundColor = UIColor.black
        #endif
        
        sharedCode = SharedCode()
 
        sharedCode.setup(scene: scene, ship: ship, lightNode: lightNode, cameraNode: cameraNode)
 
        //scnView.delegate = sharedCode
    }
    
    // A peripheral connected so we're going to adjust the motion settings
    // to maximize performance, and turn motion detection on
    @objc func controllerDidConnect(notification: NSNotification) {
        guard let newController: VgcController = notification.object as? VgcController else {
            vgcLogDebug("Got nil controller in controllerDidConnect")
            return
        }
        vgcLogDebug("Got controllerDidConnect notification")
        VgcManager.peripheralSetup.motionActive = true
        VgcManager.peripheralSetup.enableMotionAttitude = true
        VgcManager.peripheralSetup.enableMotionGravity = false
        VgcManager.peripheralSetup.enableMotionUserAcceleration = false
        VgcManager.peripheralSetup.enableMotionRotationRate = false
        VgcManager.peripheralSetup.sendToController(newController)
    }

    
}
