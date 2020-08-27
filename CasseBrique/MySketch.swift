import SwiftProcessing
import UIKit

class MySketch: Sketch, SketchDelegate{
    
    var ball : Ball?
    var tiles : [Tile] = []
    var paddle : Paddle?
    
    func setup() {
        appMode()
        reset()
    }
    
    func draw() {
        background(255,255,255)
        fill(255, 0, 0)
        ball!.move()
        drawBall(ball: ball!)
        
        
        for tile in tiles {
            if (tile.isShown){
                
                fill(tile.color)
                rect(tile.position.x, tile.position.y, tile.sideLength, tile.sideLength)
        
                ball?.checkForTileHit(tile: tile)
            }
        }
        
        moveControls()
        rect(paddle!.currentPos.x, paddle!.currentPos.y, paddle!.width, 9)
        paddle?.mustDeflectBall(ball: ball!)
        
        
        
        
        checkIfBallGetsOffEdges(ball: ball!)
    }
    
    func drawBall(ball: Ball){
        circle(ball.currentPos.x, ball.currentPos.y, ball.radius * 2)
    }
    
    func moveControls(){
        if (touches.count > 0){
            
            if touches[0].x < deviceWidth / 2 {
                paddle!.moveLeft()
            } else {
                paddle!.moveRight()
            }
            

        }
    }
    
    
    func checkIfBallGetsOffEdges(ball: Ball){
        
        let ballLeft = ball.currentPos.x - ball.radius
        let ballRight = ball.currentPos.x + ball.radius
        let ballTop = ball.currentPos.y - ball.radius
        let ballBot = ball.currentPos.y + ball.radius
        let leftEdge = CGFloat(0)
        let rightEdge = deviceWidth
        let topEdge = CGFloat(0)
        let bottomEdge = deviceHeight
        
        if (ballLeft < leftEdge || ballRight > rightEdge){
            ball.bouncesOffAWall(isVerticalWall: true)
            
        } else if (ballTop < topEdge ){
            ball.bouncesOffAWall(isVerticalWall: false)
        } else if (ballBot > bottomEdge) {
            reset()
        }
        
    }
    
    func createArrayOfTiles(rows: Int, cols: Int, gap: CGFloat) -> [Tile] {
        let gap = gap
        let disposableWidth = deviceWidth - CGFloat(gap * CGFloat((cols + 1)))
        let tileWidth = disposableWidth / CGFloat(cols)
        var tiles : [Tile] = []
        
        for j in 0...rows {
            for i in 0...cols - 1 {
                let randomRed = random(0, 255)
                let randomGreen = random(0, 255)
                let randomBlue = random(0, 255)
                let tile = Tile(position: CGPoint(x: (gap * CGFloat(i + 1)) + (tileWidth * CGFloat(i)) , y: (gap * CGFloat(j + 1)) + (tileWidth * CGFloat(j))), sideLength: tileWidth, color: Color(randomRed, randomGreen, randomBlue))
                tiles.append(tile)
            }
        }
        
        
        return tiles
    }
    
    func reset(){
        ball = Ball(radius: 5, currentPos: CGPoint(x: deviceWidth/2, y: deviceHeight/2), speed: 5, currentAngle: CGFloat(Double.pi / 2.67 ))
        
        tiles = createArrayOfTiles(rows: 5, cols: 10, gap: 5)
        
        let paddleWidth = deviceWidth / 4
        let paddleXStart = deviceWidth / 2 - (CGFloat(paddleWidth / 2))
        paddle = Paddle(width: CGFloat(paddleWidth), currentPos: CGPoint(x: paddleXStart, y: deviceHeight - 10), moveSpeed: 10, deviceWidth: deviceWidth)
    }
    
}
