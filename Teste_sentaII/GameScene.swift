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
    var ponto_sentar: SKSpriteNode? //este ponto determina quando o cachorro ira sentar
    var ponto_cabeca: SKSpriteNode? //este ponto determina quando o cachorro ira olhar para cima
    var label_qtTentativas: SKLabelNode?
    var podeInterceptar: Bool = true
    var quantidadeDeTentativasAntesTreino: Int = 0
    var alerta: SCLAlertView = SCLAlertView()
    
    
    
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
            
            //primeiramente o usuario devera chegar ate o ponto da cabeca do cachorro
            //para que ele olhe para cima.
            
          
            
            
            
            
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
        
                
                //Verifica o estagio em que o treinamento se encontra
                switch Helper.estagioTreinamento {
                    
                    case trainStage.somenteComVoz.rawValue: //treinamento somente com voz
                        print("[GameScene]: ADICIONAR COMANDO DE VOZ")
                        tocarComando()
                    case trainStage.comVozEGesto.rawValue: //Treinamento com voz e gesto
                         print("[GameScene]: ADICIONAR GESTO E COMANDO DE VOZ ")
                         tocarComando()
                    
                    
                    
                    
                    default: //acao padrao, treinamento somente com petisco
                        print("[GameScene]: Treinamento basico, somente com petisco")
                }
                
                

                
                /*Verifica agora a quantidade de treinos que ja foram realizados antes de treinar
                 com o animal e tambem controla o estado das animacoes do treinamento pelo 
                 aplicativo*/
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    
                    //Condicao para treinar com o cachorro
                    if self.quantidadeDeTentativasAntesTreino == 3 {
                        print("[GameScene]: Atingiu a quantidade maxima de treino")
                        
                        //chama o alerta de treinamento com o animal e depois de 3 tentativas no app
                        self.alerta.alertarWarning(titulo: "Treinar com o cachorro", textoBase: "Treine com o seu animal agora", textoBotao: "OK", completionHandler: { 
                            self.loadNewScene()
                        })
                        
                        
                        
                    }else {
                        self.recolocarSprites()

                    }
                    
                    
                    
                })
                
                
            }
        }
        
        
    }
    
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        

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
    
    
    
    
    func verificarEtapaTreinamento() { //VERIFICAR POSSIVEIS ERROS LOGICOS QUE PODEM OCORRER NESTA FUNCAO
        
        switch Helper.estagioTreinamento {
            
            case trainStage.somenteComVoz.rawValue: //treinamento somente com voz
            
                //coloque aqui os elementos responsaveis por ter qeu gerir o treinamento com voz
                print("[GameScene]: TEM QUE TREINAR COM VOZ")
                alerta.alertarWarning(titulo: "Treinar com comando voz", textoBase: "Agora treine o seu animal dando o comando de voz", textoBotao: "OK")

            case trainStage.comVozEGesto.rawValue: //treinamento com voz e gesto
            
                //coloque aqui os elementos responsaveis por ter que gerir o treinamento com gestos.
                print("[GameScene]: TEM QUE TREINAR COM GESTO")
                alerta.alertarWarning(titulo: "Treinar também com gestos", textoBase: "Agora treine com gestos e voz", textoBotao: "OK")

            
            default:
                break
        }
        
        
    }
    
    
    
    
    func tocarComando() {
        
        /*Aqui deve ser verificado a regiao do telefone para que carregue o audio correto*/
        
        
        //por hora tocando qualquer coisa somente para testar
        SimpleAudioPlayBack.sharedPlayback.playAudio(source: "latidoPos", type: "mp3")
        
    }

    
    


    
    
}
