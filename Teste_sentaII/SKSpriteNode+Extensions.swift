//
//  SKSpriteNode+Extensions.swift
//  Teste_sentaII
//
//  Created by Edson  Jr on 18/10/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit


extension SKSpriteNode {


    /*Esta funcao serve para se o ponto central de um sprite node intercepta o ponto central de outro node*/
    
    func interceptaCentro(outroNode: SKSpriteNode) -> Bool{
        let myCenter = CGPoint(x: self.position.x/2, y: self.position.y/2)
        let outroCenter = CGPoint(x: outroNode.position.x/2, y: outroNode.position.y/2)
        
        print("\(myCenter) | \(outroCenter)")
        
        if myCenter == outroCenter {
            return true
        }else {
            return false
        }
        
    
    
    }

}
