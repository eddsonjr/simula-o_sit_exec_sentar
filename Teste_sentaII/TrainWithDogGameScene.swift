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
        
        
        
        
        
        
        
        
        if !TrainWithDogGameScene.jaIniciado {
            //Teste - Criando a barra de progresso
            configurarProgressBar()
        }else {
            //Verifica as condicoes do progresso de treinamento para configurar a barra de progresso
            verificarAndamentoDoProcessoDeTreinamento()
        }
        
        
        
        
        

    
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
                //atualizarBarraProgresso(crescimento: 25)
                updateProgressBar(progress: CGFloat(15))
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
    
    
    
    
    
    func atualizarBarraProgresso(crescimento: CGFloat){
        
        self.barraProgresso?.alpha = 1.0
        SentaHelper.tamanhoBarraDeProgresso = (Float((self.barraProgresso?.size.width)! + crescimento))
        SentaHelper.porcentagemGeralDoPrgoresso = SentaHelper.porcentagemGeralDoPrgoresso + 15
        self.barraProgresso?.size = CGSize(width: Int(SentaHelper.tamanhoBarraDeProgresso), height: 35)
        
        print("Porcentagem ja adquirida: \(SentaHelper.porcentagemGeralDoPrgoresso)")
    }
    
    

    
    
    func chamarCenaAnterior() {
        
        
        guard let gameScene = SKScene(fileNamed: "SentaGameScene") else { return }
        let fadeTransition = SKTransition.crossFade(withDuration: 0.5)
        self.view?.presentScene(gameScene, transition: fadeTransition)
        
    }

    
    
    
    
    //Esta funcao e responsavel por verificar o andamento do adestramento do animal e setar as condicoes
    //e configuracoes dos elementos na tela.
    func verificarAndamentoDoProcessoDeTreinamento() {
        
        
        if SentaHelper.porcentagemGeralDoPrgoresso > 0 {
            
        }
        
        
        
        //Se a porcentagem de treinamento é zero, entao a barra de progresso nao existe ou esta vazia
        if SentaHelper.porcentagemGeralDoPrgoresso == 0{
            self.barraProgresso?.alpha = 0.0
        }else if SentaHelper.porcentagemGeralDoPrgoresso > 0 {
            self.barraProgresso?.alpha = 1.0
            self.barraProgresso?.size = CGSize(width: Int(SentaHelper.tamanhoBarraDeProgresso), height: 35)
        }
    }
    
    
    func configurarProgressBar() {
        
        
        //Outline da barra de progresso
        progressBarOutline.path = UIBezierPath(roundedRect: CGRect(x: frame.minX + 10, y: -128, width: 500, height: 24), cornerRadius: 4).cgPath
        progressBarOutline.fillColor = UIColor.clear
        progressBarOutline.strokeColor = UIColor.black
        progressBarOutline.lineWidth = 2
        
        
        //Preenchimento da barra de progresso
        insideShapeProgressBar.path = UIBezierPath(roundedRect: CGRect(x: progressBarOutline.frame.minX+3, y: progressBarOutline.frame.minY-1, width: 0, height: progressBarOutline.frame.height-2), cornerRadius: 1).cgPath
        insideShapeProgressBar.fillColor = UIColor.purple
        insideShapeProgressBar.strokeColor = UIColor.clear
        insideShapeProgressBar.lineWidth = 2
        
        
        addChild(progressBarOutline)
        progressBarOutline.addChild(insideShapeProgressBar)
    }
    
    
    
    
    
    
    func updateProgressBar(progress: CGFloat) {
        var montante = (self.insideShapeProgressBar.frame.width + progress)
        
        if (montante >= self.progressBarOutline.frame.width) {
            print("Montante: \(montante) | Completado: \(self.insideShapeProgressBar.frame.width) | Progresso: \(progress)")
            let novoMontante = self.progressBarOutline.frame.width - self.insideShapeProgressBar.frame.width + self.insideShapeProgressBar.frame.width - 6
            
            self.insideShapeProgressBar.path = UIBezierPath(roundedRect: CGRect(x: progressBarOutline.frame.minX+3, y: progressBarOutline.frame.minY+3, width: novoMontante, height: progressBarOutline.frame.height-6), cornerRadius: 1).cgPath
            
            
        }else {
             self.insideShapeProgressBar.path = UIBezierPath(roundedRect: CGRect(x: progressBarOutline.frame.minX+3, y: progressBarOutline.frame.minY+3, width: montante, height: progressBarOutline.frame.height-6), cornerRadius: 1).cgPath
        }
        
        SentaHelper.porcentagemGeralDoPrgoresso = SentaHelper.porcentagemGeralDoPrgoresso + 15
        print("Porcentagem ja adquirida: \(SentaHelper.porcentagemGeralDoPrgoresso)")

    }
    
    
    
    


}
