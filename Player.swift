//
//  Player.swift
//  Jack and The Beanstock
//
//  Created by Bernard Huff on 8/29/17.
//  Copyright © 2017 Flyhighgames. All rights reserved.
//
//  Timestamp: Lecture 43 - 1:00

import SpriteKit

//  Below is where I added the code for the structs in the gamescene.

struct ColliderType {
    
    static let Player: UInt32 = 0;
    static let Clouds: UInt32 = 1;
    static let DarkCloudAndCollectables: UInt32 = 2;
    
}

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas();
    private var playerAnimation = [SKTexture]();
    private var animatePlayerAction = SKAction();

    // Below is where I initialized the player and his actions.
    
    func initializePlayerAndAnimations() {
    
        textureAtlas = SKTextureAtlas(named: "Player.atlas");
        
        for i in 2...textureAtlas.textureNames.count {
        
            let name = "Player \(i)";
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false);
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 50, height: self.size.height - 5));
        
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.restitution = 0; 
        self.physicsBody?.categoryBitMask = ColliderType.Player;
        self.physicsBody?.collisionBitMask = ColliderType.Clouds;
        self.physicsBody?.contactTestBitMask = ColliderType.DarkCloudAndCollectables;
        
    // Here is where you define the player animations.
        
    }
    
    // Below is where I create the function to animate the player.
    
    func animatePlayer(moveLeft: Bool) {
     
        if moveLeft {
        
            self.xScale = -fabs(self.xScale);
            
        } else {
        
            self.xScale = fabs(self.xScale);
            
        }
        
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate");
        
    }
    
    func stopPlayerAnimation() {
    
        self.removeAction(forKey: "Animate");
        self.texture = SKTexture(imageNamed: "Player 1");
        self.size = (self.texture?.size())!
    }
    
    // Below is where I set up the move left function. 
    
    func movePlayer(moveLeft: Bool) {
    
        if moveLeft {
            self.position.x -= 7;
        } else {
            self.position.x += 7;
        }
    }
}





















