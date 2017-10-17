//
//  GameScene.swift
//  Teste_sentaII
//
//  Created by Edson  Jr on 16/10/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene {
    
    var petisco: SKSpriteNode?
    var cachorro: SKSpriteNode?
    var ponto_sentar: SKSpriteNode?
    var label_qtTentativas: SKLabelNode?
    var podeInterceptar: Bool = true
    var quantidadeDeTentativasAntesTreino: Int = 0
    
    
    override func didMove(to view: SKView){
        
        print("In didMove")
        self.petisco = self.childNode(withName: "petisco") as? SKSpriteNode
        self.cachorro = self.childNode(withName: "cachorro") as? SKSpriteNode
        self.ponto_sentar = self.childNode(withName: "ponto_senta") as? SKSpriteNode
        self.label_qtTentativas = self.childNode(withName: "qt_Tentativas") as? SKLabelNode
        
        //Inicializando a label
        self.label_qtTentativas?.text = String(self.quantidadeDeTentativasAntesTreino)
        
        
        //verificando as etapas do treinamento
        verificarEtapaTreinamento()
        
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
        
        
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            self.petisco?.position = location
            
            
            if ((self.petisco?.intersects(self.ponto_sentar!))! && self.podeInterceptar) {
                print("Atingiu o ponto para sentar")
                
                //removendo a interacao do usuario com a tela
                view?.isUserInteractionEnabled = false
                self.podeInterceptar = false
                
                let newTexture = SKTexture(image: #imageLiteral(resourceName: "dog_sit"))
                self.cachorro?.texture = newTexture
                
                //Atualizando o contador de tentativas e printando na tela
                self.quantidadeDeTentativasAntesTreino = self.quantidadeDeTentativasAntesTreino + 1
                self.label_qtTentativas?.text = String(quantidadeDeTentativasAntesTreino)
                
                
                //verificando se ja e para colocar o comando de voz
                if Helper.treinarComVoz {
                    print("[GameScene]: ADICIONAR COMANDO DE VOZ")
                }
                
                if Helper.treinarComGesto {
                    print("[GameScene]: ADICIONAR GESTO")
                }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.recolocarSprites()
                
                })
                
                
            }
        }
        
        
    }
    
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        //verificando se ja foram realizada as 3 tentativas de treinamento do cachorro para depois
        //chamar a tela de treinamento do cachorro
        if self.quantidadeDeTentativasAntesTreino == 3 {
            self.loadNewScene()
            return
        }
        

        
        
    }
    
    
    
    
    
    func loadNewScene() {
        
        guard let TrainScene = SKScene(fileNamed: "TrainWithDog") else { return }
        let fadeTransition = SKTransition.crossFade(withDuration: 0.5)
        view?.presentScene(TrainScene, transition: fadeTransition)
        
    
    
    }
    
    
    
    func recolocarSprites() {
        
        //voltando o petisco para a posicao atual
        self.petisco?.position = CGPoint(x: 304, y: 143)
        
        //mudando a textura do cachorro para ele em pe novamente
        self.cachorro?.texture = SKTexture(image: #imageLiteral(resourceName: "dog"))
        
        
        //colocando a interacao da tela com o usuario novamente
        view?.isUserInteractionEnabled = true
        self.podeInterceptar = true
        
    }
    
    
    
    
    func verificarEtapaTreinamento() {
        
        if Helper.treinarComVoz{
            //coloque aqui os elementos responsaveis por ter qeu gerir o treinamento com voz
            print("[GameScene]: TEM QUE TREINAR COM VOZ")
        }
        
        
        if Helper.treinarComGesto {
            //coloque aqui os elementos responsaveis por ter que gerir o treinamento com gestos.
            print("[GameScene]: TEM QUE TREINAR COM GESTO")
        }
        
    }
    
    
}
