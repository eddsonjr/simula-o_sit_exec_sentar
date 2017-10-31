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

    func animarSequencia(texturas: [SKTexture],intervalo: TimeInterval,quantRepeticoes: Int,completionHander: @escaping ()->Void){
        print("Executando animacao de sequencia")
        let sequence = SKAction.repeat(SKAction.animate(with: texturas, timePerFrame: intervalo), count: quantRepeticoes)
        self.run(sequence, completion: completionHander)
    }

    
}
