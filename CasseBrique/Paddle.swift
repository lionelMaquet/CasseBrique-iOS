//
//  Paddle.swift
//  CasseBrique
//
//  Created by Lionel Maquet on 11/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import Foundation
import CoreGraphics

class Paddle {
    var width: CGFloat
    var currentPos : CGPoint
    var moveSpeed : CGFloat
    var deviceWidth : CGFloat
    
    
    init(width:CGFloat,currentPos:CGPoint,moveSpeed:CGFloat, deviceWidth: CGFloat){
        self.width = width
        self.currentPos = currentPos
        self.moveSpeed = moveSpeed
        self.deviceWidth = deviceWidth
    }
    
    func mustDeflectBall(ball: Ball) {
        if (ball.currentPos.y + ball.radius > self.currentPos.y &&
            ball.currentPos.x > self.currentPos.x &&
            ball.currentPos.x < self.currentPos.x + self.width){
            ball.currentAngle = self.calculateAngle(ball: ball)
        }
    }
    
    func moveLeft(){
        
        if currentPos.x > 0 {
            currentPos.x -= self.moveSpeed
        }
        
        
    }
    
    func moveRight(){
        if ((currentPos.x + self.width) < deviceWidth) {
            currentPos.x += self.moveSpeed
        }
        
    }
    
    func calculateAngle(ball: Ball) -> CGFloat {
        let ballX = ball.currentPos.x
        let paddleX = self.currentPos.x
        let distanceHitFromBeginningOfPaddle = ballX - paddleX
        let percentageDistance = self.width / distanceHitFromBeginningOfPaddle
        let returnAngle = CGFloat(Double.pi) / percentageDistance
        return returnAngle + CGFloat(Double.pi)
        
    }
}
