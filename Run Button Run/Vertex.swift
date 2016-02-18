//
//  Vertex.swift
//  Run Button Run
//
//  Created by Garrett Haufschild on 2/18/16.
//  Copyright © 2016 Swag Productions. All rights reserved.
//

import UIKit

class Vertex: NSObject {

    var x: Int
    var y: Int
    var neighbors: Array<Vertex>
    
    override init() {
        x = 0
        y = 0
    }
    
    init(x: Int, y: Int)
    {
        self.x = x
        self.y = y
    }
}
