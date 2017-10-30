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
    let progressBarOutline = SKShapeNode()
    var insideShapeProgressBar = SKShapeNode()
    let incrementoPorcentagem = CGFloat(10)
    
    
    var progressBar: ProgressBarSpriteKit? //Barra de progresso
    
    
    //Variavel de alerta
    var alerta: SCLAlertView = SCLAlertView()
    
    
    override func didMove(to view: SKView){
        
        print("NA DIDMOVETOVIEW DO BARRA DE PROGRESSO")
        view.isUserInteractionEnabled = true
        
        self.ossoVazado1 = self.childNode(withName: "ossoVazado1") as? SKSpriteNode
       
        
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
                SentaHelper.porcentagemGeralDoPrgoresso = SentaHelper.porcentagemGeralDoPrgoresso + self.incrementoPorcentagem
                print("Porcentagem adquirida: \(SentaHelper.porcentagemGeralDoPrgoresso)")
                self.progressBar?.atualizarProgressoBarra(porcengatem: SentaHelper.porcentagemGeralDoPrgoresso)
            }
        }
    }
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
        //Se o progresso ja chegou em determinada porcentagem o treinamento estava ocorrendo sem voz
         //carregar a cena anterior e setar o treinamento para comecar com voz
        if SentaHelper.porcentagemGeralDoPrgoresso == 30 && SentaHelper.estagioTreinamento == SentatrainStage.somenteComPetisco.rawValue{
            print("[TELA DE PROGRESSO]: Adicionar comando de voz")
            SentaHelper.estagioTreinamento = SentatrainStage.somenteComVoz.rawValue
            
            //Desativando o botao de interacao para impedir o usuario de clicar e fazer mais porcentagens
            self.ossoVazado1?.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.chamarCenaAnterior()
                return

            })
        }
 
        
        //Se o progresso ja chegou em <%> e ja houve o treinamento com voz, entao chamar a tela
        //anterior e treinar com voz e gesto
        if SentaHelper.porcentagemGeralDoPrgoresso == 70 && SentaHelper.estagioTreinamento == SentatrainStage.somenteComVoz.rawValue {
            print("[TELA DE PROGRESSO]: Adicionar gesto")
            SentaHelper.estagioTreinamento = SentatrainStage.comVozEGesto.rawValue
            print("TELAPROGRESSO: \(SentaHelper.estagioTreinamento)")
            chamarCenaAnterior()
            return
        }


        
        
        //Se o progresso ja chegou em 100% e houve os treinamentos com voz e com gesto, chamar a tela
        // de feedback pois o exercicio terminou
        if SentaHelper.porcentagemGeralDoPrgoresso >= 100 && SentaHelper.estagioTreinamento == SentatrainStage.comVozEGesto.rawValue {
            SentaHelper.estagioTreinamento = SentatrainStage.treinamentoCompletado.rawValue
            print("CHAMAR A TELA DE FEEDBACK AQUI")
            /*CHAME A TELA DE FEEDBACK AQUI*/
            
        }
        
        
}
    
    
    
    func chamarCenaAnterior() {
        
        
        guard let gameScene = SKScene(fileNamed: "SentaGameScene") else { return }
        let fadeTransition = SKTransition.crossFade(withDuration: 0.5)
        self.view?.presentScene(gameScene, transition: fadeTransition)
        
    }
}
