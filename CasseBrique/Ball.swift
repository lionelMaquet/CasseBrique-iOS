//
//  Ball.swift
//  CasseBrique
//
//  Created by Lionel Maquet on 11/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import Foundation
import CoreGraphics

class Ball {
    var radius: CGFloat
    var currentPos: CGPoint
    var speed: CGFloat
    var currentAngle : CGFloat
    
    init(radius:CGFloat,currentPos:CGPoint,speed:CGFloat,currentAngle:CGFloat){
        self.radius = radius
        self.currentPos = currentPos
        self.speed = speed
        self.currentAngle = currentAngle
    }
    
    func move(){
        currentPos.x += speed * cos(currentAngle)
        currentPos.y += speed * sin(currentAngle)
    }
    
    func bouncesOffAWall(isVerticalWall: Bool){
        if isVerticalWall{
            currentAngle = CGFloat((Double.pi )) - currentAngle
        } else {
            currentAngle = CGFloat((Double.pi * 2 )) - currentAngle
        }
    }
    
    func checkForTileHit(tile : Tile){
        let ballLeft = self.currentPos.x - self.radius
        let ballRight = self.currentPos.x + self.radius
        let ballTop = self.currentPos.y - self.radius
        let ballBot = self.currentPos.y + self.radius
        let leftEdge = tile.position.x
        let rightEdge = tile.position.x + tile.sideLength
        let topEdge = tile.position.y
        let bottomEdge = tile.position.y + tile.sideLength
        
        
        var didHitTile = false
        
        // left
        if (ballLeft < rightEdge && ballLeft > leftEdge && self.currentPos.y < bottomEdge && self.currentPos.y > topEdge){
            self.bouncesOffAWall(isVerticalWall: true)
            didHitTile = true
        }
        
        //right
        else if (ballRight > leftEdge && ballRight < rightEdge && self.currentPos.y < bottomEdge && self.currentPos.y > topEdge){
            self.bouncesOffAWall(isVerticalWall: true)
            didHitTile = true
        }
        
        //from top
        else if (ballTop > topEdge && ballTop < bottomEdge && self.currentPos.x > leftEdge && self.currentPos.x < rightEdge){
            self.bouncesOffAWall(isVerticalWall: false)
            didHitTile = true
        }
        
        else if (ballBot < bottomEdge && ballBot > topEdge && self.currentPos.x > leftEdge && self.currentPos.x < rightEdge){
            self.bouncesOffAWall(isVerticalWall: false)
            didHitTile = true
        }
        
        if (didHitTile){
            tile.disappears()
        }
        
    }
}
