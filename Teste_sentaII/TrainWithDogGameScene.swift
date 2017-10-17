//
//  TrainWithDogGameScene.swift
//  teste_Senta
//
//  Created by Edson  Jr on 01/09/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TrainWithDogGameScene: SKScene {
    
    
    
    var ossoVazado1: SKSpriteNode?
    var barraProgresso: SKSpriteNode?
    
    var ossosRestantes: Int = 3
    
    
    override func didMove(to view: SKView){
        
        print("NA DIDMOVETOVIEW DO BARRA DE PROGRESSO")
        view.isUserInteractionEnabled = true
        
        
        self.ossoVazado1 = self.childNode(withName: "ossoVazado1") as? SKSpriteNode
        self.barraProgresso = self.childNode(withName: "barraProgresso") as? SKSpriteNode
        self.barraProgresso?.alpha = 0.0
    
    }
    
    
    override func sceneDidLoad() {
        
        
    }
    
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    
    
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Tela tocada")
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if (self.ossoVazado1?.contains(location))!{
                print("Osso vazado 1 tocado")
                atualizarBarraProgresso(crescimento: 25)
            }
        }
    }
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
       
        if Helper.porcentagemGeralDoPrgoresso == 45 {
            Helper.treinarComVoz = true
            chamarCenaAnterior()
        }
        
        
    }
    
    
    
    
    
    func atualizarBarraProgresso(crescimento: CGFloat){
        self.barraProgresso?.alpha = 1.0
        Helper.tamanhoBarraDeProgresso = (Float((self.barraProgresso?.size.width)! + crescimento))
        Helper.porcentagemGeralDoPrgoresso = Helper.porcentagemGeralDoPrgoresso + 15
        self.barraProgresso?.size = CGSize(width: Int(Helper.tamanhoBarraDeProgresso), height: 35)
        
        print("Porcentagem ja adquirida: \(Helper.porcentagemGeralDoPrgoresso)")
    }
    
    

    
    
    func chamarCenaAnterior() {
        
        
        guard let gameScene = SKScene(fileNamed: "GameScene") else { return }
        let fadeTransition = SKTransition.crossFade(withDuration: 0.5)
        view?.presentScene(gameScene, transition: fadeTransition)
        
        
        
//        let cena1 = GameScene(fileNamed: "GameScene")
//        
//        self.removeFromParent()
//        self.view?.presentScene(cena1!, transition: fadeTransition)
    }

    


}
