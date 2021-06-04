//
//  GameplayScene.swift
//  Jack and The Beanstock
//
//  Created by Bernard Huff on 8/28/17.
//  Copyright © 2017 Flyhighgames. All rights reserved.
//
//  Timestamp: Lesson 44 | Beginning

import SpriteKit

class GameplayScene: SKScene {
    
    var cloudsController = CloudsController();
    
    var mainCamera: SKCameraNode?;
    
    var bg1: BGClass?;
    var bg2: BGClass?;
    var bg3: BGClass?;
    
    var player: Player?;
    
    var canMove = false;
    var moveLeft = false;
    
    var center: CGFloat?;
    
    var distanceBetweenClouds = CGFloat(240);
    let minX = CGFloat(-157);
    let maxX = CGFloat(157);
    
    override func didMove(to view: SKView) {
        initializeVariables();
    }
    
    override func update(_ currentTime: TimeInterval) {
//        moveCamera();
        managePlayer();
        manageBackgrounds();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
            
            if location.x > center! {
                moveLeft = false;
                player?.animatePlayer(moveLeft: moveLeft);
            } else {
                moveLeft = true;
                player?.animatePlayer(moveLeft: moveLeft);
            }
        }
        
        canMove = true;
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false;
        player?.stopPlayerAnimation();
    }
    
    func initializeVariables() {
        
        center = (self.scene?.size.width)! / (self.scene?.size.height)!;
        player = self.childNode(withName: "Player") as? Player? as! Player;
        player?.initializePlayerAndAnimations();
        
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode? as! SKCameraNode;
        
        getBackgrounds();
        
        cloudsController.arrangeCloudsInScene(scene: scene!, distaneBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, player: player!,initialClouds: true);
        
    }
    
    func getBackgrounds() {
    
        bg1 = self.childNode(withName: "BG 1") as? BGClass? as! BGClass;
        bg2 = self.childNode(withName: "BG 2") as? BGClass? as! BGClass;
        bg3 = self.childNode(withName: "BG 3") as? BGClass? as! BGClass;
        
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft);
        }
    }
    
    func  moveCamera() {
        self.mainCamera?.position.y -= 3;
    }
    
    func manageBackgrounds() {
    
        bg1?.moveBG(camera: (mainCamera)!);
        bg2?.moveBG(camera: (mainCamera)!);
        bg3?.moveBG(camera: (mainCamera)!);
    }
}






