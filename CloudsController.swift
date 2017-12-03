//
//  CloudsController.swift
//  Jack and The Beanstock
//
//  Created by Bernard Huff on 8/31/17.
//  Copyright © 2017 Flyhighgames. All rights reserved.
//
//  Timestamp: Lecture 43 - 7:00

import SpriteKit

class CloudsController {
    
    var lastCloudPositionY = CGFloat();
    
    // I had to hack my way thru the shuffle functions. 
    
    func shuffle( cloudsArray: [SKSpriteNode]) -> [SKSpriteNode]{
        
        var cloudsArray = cloudsArray
        
        for i in 0..<cloudsArray.count {
            let j = Int(arc4random_uniform(UInt32(cloudsArray.count - i))) + i;
            if i == j {continue}
            cloudsArray.swapAt(i, j);cloudsArray.swapAt(i, j);
        }
        
        return cloudsArray;
        
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
    
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum);
    }

    func createClouds() -> [SKSpriteNode] {
    
        var clouds = [SKSpriteNode]();
        
        for _ in 0 ..< 2 {
            let cloud1 = SKSpriteNode(imageNamed: "Cloud 1");
            cloud1.name = "1";
            let cloud2 = SKSpriteNode(imageNamed: "Cloud 2");
            cloud2.name = "2";
            let cloud3 = SKSpriteNode(imageNamed: "Cloud 3");
            cloud3.name = "3"
            let darkCloud = SKSpriteNode(imageNamed: "Dark Cloud");
            darkCloud.name = "Dark Cloud";
            
            cloud1.xScale = 0.9;
            cloud1.yScale = 0.9;
            
            cloud2.xScale = 0.9;
            cloud2.yScale = 0.9;
            
            cloud3.xScale = 0.9;
            cloud3.yScale = 0.9;
            
            darkCloud.xScale = 0.9;
            darkCloud.yScale = 0.9;
            
            // Add physics body to clouds below
            
//            Cloud 1
            cloud1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud1.size.width - 5, height: cloud1.size.height - 6));
            cloud1.physicsBody?.affectedByGravity = false;
            cloud1.physicsBody?.restitution = 0;
            cloud1.physicsBody?.categoryBitMask = ColliderType.Clouds;
            cloud1.physicsBody?.collisionBitMask = ColliderType.Player;
            
//            Cloud 2
            cloud2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud2.size.width - 5, height: cloud2.size.height - 6));
            cloud2.physicsBody?.affectedByGravity = false;
            cloud2.physicsBody?.restitution = 0;
            cloud2.physicsBody?.categoryBitMask = ColliderType.Clouds;
            cloud2.physicsBody?.collisionBitMask = ColliderType.Player;

//            Cloud 3
            cloud3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud3.size.width - 5, height: cloud3.size.height - 6));
            cloud3.physicsBody?.affectedByGravity = false;
            cloud3.physicsBody?.restitution = 0;
            cloud3.physicsBody?.categoryBitMask = ColliderType.Clouds;
            cloud3.physicsBody?.collisionBitMask = ColliderType.Player;

//            DarkCloud
            darkCloud.physicsBody = SKPhysicsBody(rectangleOf: darkCloud.size);
            darkCloud.physicsBody?.affectedByGravity = false;
            darkCloud.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectables;
            darkCloud.physicsBody?.collisionBitMask = ColliderType.Player;

            
            clouds.append(cloud1);
            clouds.append(cloud2);
            clouds.append(cloud3);
            clouds.append(darkCloud);
            
        }
        
        clouds = shuffle(cloudsArray: clouds);
        
        return clouds;
    }
    
    func arrangeCloudsInScene(scene: SKScene, distaneBetweenClouds: CGFloat, center: CGFloat, minX: CGFloat, maxX: CGFloat, player: Player, initialClouds: Bool) {
    
        var clouds = createClouds();
        
        if initialClouds {
            
            while(clouds[0].name == "Dark Cloud") {
            
                // Shuffle the cloud array
                clouds = shuffle(cloudsArray: clouds);
            }
        }
        
        var positionY = CGFloat();
        
        if initialClouds {
        
            positionY = center - 100;
            
        } else {
        
            positionY = lastCloudPositionY;
            
        }
        //print("The random number is \(cloudsController.randomBetweenNumbers(firstNum: 2, secondNum: 5 ))");
        
        var random = 0;
        
        for i in 0...clouds.count - 1 {
            
            var randomX = CGFloat();
            
            if random == 0 {
            
                randomX = randomBetweenNumbers(firstNum: center + 90, secondNum: maxX);
                random = 1;
                
            } else if random == 1 {
            
                randomX = randomBetweenNumbers(firstNum: center - 90, secondNum: minX);
                random = 0
            }
        
            clouds[i].position = CGPoint(x: randomX, y: positionY);
            clouds[i].zPosition = 3;
            
            
            scene.addChild(clouds[i]);
            positionY -= distaneBetweenClouds;
            
            lastCloudPositionY =  positionY;
            
        }
        
        
    }
}






















