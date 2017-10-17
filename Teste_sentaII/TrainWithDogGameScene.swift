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
        
        //Verifica as condicoes do progresso de treinamento para configurar a barra de progresso
        verificarAndamentoDoProcessoDeTreinamento()
       
    
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
        
       
        //Se o progresso ja chegou em determinada porcentagem o treinamento estava ocorrendo sem voz
        // carregar a cena anterior e setar o treinamento para comecar com voz
        if Helper.porcentagemGeralDoPrgoresso == 45 && Helper.treinarComVoz == false {
            print("[TELA DE PROGRESSO]: Adicionar comando de voz")
            Helper.treinarComVoz = true
            chamarCenaAnterior()
            return
        }
        
        
        //Se o progresso ja chegou em <75%> e ja houve o treinamento com voz, entao chamar a tela
        //anterior e treinar com voz e gesto
        if Helper.porcentagemGeralDoPrgoresso == 90 && Helper.treinarComVoz {
            print("[TELA DE PROGRESSO]: Adicionar gesto")
            Helper.treinarComGesto = true
            chamarCenaAnterior()
            return
        }
        
        
        //Se o progresso ja chegou em 100% e houve os treinamentos com voz e com gesto, chamar a tela
        // de feedback pois o exercicio terminou
        if Helper.treinarComGesto && Helper.treinarComVoz {
            if Helper.porcentagemGeralDoPrgoresso >= 150 {
                 print("CHAMAR A TELA DE FEEDBACK")
            }
           
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
        self.view?.presentScene(gameScene, transition: fadeTransition)
        
    }

    
    
    
    
    //Esta funcao e responsavel por verificar o andamento do adestramento do animal e setar as condicoes
    //e configuracoes dos elementos na tela.
    func verificarAndamentoDoProcessoDeTreinamento() {
        
        //Se a porcentagem de treinamento é zero, entao a barra de progresso nao existe ou esta vazia
        if Helper.porcentagemGeralDoPrgoresso == 0{
            self.barraProgresso?.alpha = 0.0
        }else if Helper.porcentagemGeralDoPrgoresso > 0 {
            self.barraProgresso?.alpha = 1.0
            self.barraProgresso?.size = CGSize(width: Int(Helper.tamanhoBarraDeProgresso), height: 35)
        }
        
        
        
        
    }
    


}
