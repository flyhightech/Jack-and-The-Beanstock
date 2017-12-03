//
//  BGClass.swift
//  Jack and The Beanstock
//
//  Created by Bernard Huff on 8/30/17.
//  Copyright © 2017 Flyhighgames. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode {

    func moveBG(camera: SKCameraNode) {
    
        if self.position.y - self.size.height - 10 > camera.position.y {
        
            self.position.y -= self.size.height * 3;
        
        }
    }
}

























