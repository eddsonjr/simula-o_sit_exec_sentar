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
    
    private static var jaIniciado = false
    
    
    let progressBarOutline = SKShapeNode()
    var insideShapeProgressBar = SKShapeNode()
    
    
    
    var progressBar: ProgressBarSpriteKit? //Barra de progresso
    
    
    
    override func didMove(to view: SKView){
        
        print("NA DIDMOVETOVIEW DO BARRA DE PROGRESSO")
        view.isUserInteractionEnabled = true
        
        self.ossoVazado1 = self.childNode(withName: "ossoVazado1") as? SKSpriteNode
        self.barraProgresso = self.childNode(withName: "barraProgresso") as? SKSpriteNode
        
        
        //criando a barra de progresso do jogo
        progressBar = ProgressBarSpriteKit(rect: CGRect(x: 0, y: 0, width: 250, height: 64), lineColor: UIColor.gray, progressBarColor: UIColor.purple)
        
        //Colocando os shapes da barra de progresso na tela
        self.addChild((progressBar?.getProgressBarSpriteKitShapes().1)!) //adquiri o preenchimento
        self.addChild((progressBar?.getProgressBarSpriteKitShapes().0)!) //adquiri o outline da barra
        
        //atualizando a porcentagem da barra de progresso
        self.progressBar?.atualizarProgressoBarra(porcengatem: CGFloat(SentaHelper.porcentagemGeralDoPrgoresso))
        
        
        
        

    
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
                self.progressBar?.atualizarProgressoBarra(porcengatem: CGFloat(25))
            }
        }
    }
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
        //Se o progresso ja chegou em determinada porcentagem o treinamento estava ocorrendo sem voz
         //carregar a cena anterior e setar o treinamento para comecar com voz
        if SentaHelper.porcentagemGeralDoPrgoresso == 45 && SentaHelper.estagioTreinamento == SentatrainStage.somenteComPetisco.rawValue{
            print("[TELA DE PROGRESSO]: Adicionar comando de voz")
            SentaHelper.estagioTreinamento = SentatrainStage.somenteComVoz.rawValue
            chamarCenaAnterior()
            return

        }
 
        //Se o progresso ja chegou em <%> e ja houve o treinamento com voz, entao chamar a tela
        //anterior e treinar com voz e gesto
        if SentaHelper.porcentagemGeralDoPrgoresso == 90 && SentaHelper.estagioTreinamento == SentatrainStage.somenteComVoz.rawValue {
            print("[TELA DE PROGRESSO]: Adicionar gesto")
            SentaHelper.estagioTreinamento = SentatrainStage.comVozEGesto.rawValue
            print("TELAPROGRESSO: \(SentaHelper.estagioTreinamento)")
            chamarCenaAnterior()
            return
        }


        
        
        //Se o progresso ja chegou em 100% e houve os treinamentos com voz e com gesto, chamar a tela
        // de feedback pois o exercicio terminou

        if SentaHelper.porcentagemGeralDoPrgoresso >= 150 && SentaHelper.estagioTreinamento == SentatrainStage.comVozEGesto.rawValue {
            SentaHelper.estagioTreinamento = SentatrainStage.treinamentoCompletado.rawValue
            
        }
        
        
}
    
    
    
    func chamarCenaAnterior() {
        
        
        guard let gameScene = SKScene(fileNamed: "SentaGameScene") else { return }
        let fadeTransition = SKTransition.crossFade(withDuration: 0.5)
        self.view?.presentScene(gameScene, transition: fadeTransition)
        
    }
}
