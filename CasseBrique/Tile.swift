//
//  Tile.swift
//  CasseBrique
//
//  Created by Lionel Maquet on 11/08/2020.
//  Copyright © 2020 Lionel Maquet. All rights reserved.
//

import Foundation
import CoreGraphics
import SwiftProcessing

class Tile {
    var position : CGPoint
    var sideLength : CGFloat
    var isShown = true
    var color : Color
    
    init(position: CGPoint, sideLength: CGFloat, color: Color) {
        self.position = position
        self.sideLength = sideLength
        self.color = color
    }
    
    func disappears(){
        isShown = false
    }
    
    
}
