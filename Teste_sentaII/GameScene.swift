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
    var main_region: SKSpriteNode? //ponto geral que abrange ambos os pontos de intersecao
    var label_qtTentativas: SKLabelNode?
    var podeInterceptarPonto2: Bool = false
    var podeInterceptarPonto1: Bool = true
    var quantidadeDeTentativasAntesTreino: Int = 0
    var podeRemoverInteracaoDaTela: Bool = false
    var alerta: SCLAlertView = SCLAlertView()
    
    
    
    
    override func didMove(to view: SKView){
        
        print("In didMove")
        self.petisco = self.childNode(withName: "petisco") as? SKSpriteNode
        self.cachorro = self.childNode(withName: "cachorro") as? SKSpriteNode
        self.ponto_sentar = self.childNode(withName: "ponto_senta") as? SKSpriteNode
        self.ponto_cabeca = self.childNode(withName: "ponto_cabeca") as? SKSpriteNode
        self.main_region = self.childNode(withName: "main_region") as? SKSpriteNode
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
            
            if Helper.estagioTreinamento == trainStage.somenteComPetisco.rawValue || Helper.estagioTreinamento == trainStage.somenteComVoz.rawValue {
                
                treinamentoComOuSemVoz()
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
        
        //mudando a textura do cachorro para ele em pe novamente
        self.cachorro?.texture = SKTexture(image: #imageLiteral(resourceName: "dog"))
        
        
        //colocando a interacao da tela com o usuario novamente
        //view?.isUserInteractionEnabled = true
        self.podeInterceptarPonto2 = false
        self.podeInterceptarPonto1 = false
        
        animacaoPetiscoRetornar()
        
    }
    
    
    
    
    func verificarEtapaTreinamento() {
        
        
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
    
    
    
    
    //Animacao de fazer o petisco voltar
    func animacaoPetiscoRetornar() {
        
        let moveAnimation = SKAction.move(to: CGPoint(x: 304, y: 143), duration: 2)
        self.petisco?.run(moveAnimation)
        
    }

    
    
    
    
    /*Esta funcao e responsavel por gerenciar o treinamento nas duas primeiras etapas, tanto somente com o petisco quanto com o petisco e o som*/
    func treinamentoComOuSemVoz() {
        
        
        /*Verifica se o usuario esta com o petisco dentro da area de atuacao dos dois pontos que ele
          tem que passar */
        if (self.petisco?.intersects(self.main_region!))! {
            print("Entrou na main_region")
            
            print("Pontos de intercepcao: ponto1>> \(self.podeInterceptarPonto1) || ponto2>> \(self.podeInterceptarPonto2)")
            
            
            
            
            /*Caso o usuario tenha interceptado o ponto 1, ele troca o sprite e permite o toque
             no segundo ponto, caso contrario, ele volta para o sprite do cachorro normal, trava
             o ponto dele sentar e volta o sprite para o cachorro em pe*/
            if ((self.petisco?.intersects(self.ponto_cabeca!))! && self.podeInterceptarPonto1) {
                print("[Gamescene]: O cachoror esta olhando para cima")
                let newTexture = SKTexture(image: #imageLiteral(resourceName: "dog_look_up"))
                self.cachorro?.texture = newTexture
                self.podeInterceptarPonto2 = true
                self.podeInterceptarPonto1 = false
                
                
            }
            
            
            
            //se o usuario aproximar o petisco ainda mais proximo da cabeca do cachorro, ai sim
            //ele ira sentar
            if ((self.petisco?.intersects(self.ponto_sentar!))! && self.podeInterceptarPonto2) {
                print("Atingiu o ponto para sentar")
                
                
                self.podeInterceptarPonto2 = false //
                let newTexture = SKTexture(image: #imageLiteral(resourceName: "dog_sit"))
                self.cachorro?.texture = newTexture
                
                //Atualizando o contador de tentativas e printando na tela
                self.quantidadeDeTentativasAntesTreino = self.quantidadeDeTentativasAntesTreino + 1
                self.label_qtTentativas?.text = String(quantidadeDeTentativasAntesTreino)
                
                
                
                //verifica se tem que colocar o comando de voz
                if Helper.estagioTreinamento == trainStage.somenteComVoz.rawValue {
                    print("[GameScene]: ADICIONAR COMANDO DE VOZ")
                    tocarComando()

                }
        
                
                /*Verifica agora a quantidade de treinos que ja foram realizados antes de treinar
                 com o animal e tambem controla o estado das animacoes do treinamento pelo
                 aplicativo*/
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    
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
                    
                }) //Fecha o mainqueue
                
                
            } //Fecha o if do ponto de sentar
            
            
            
            /*Caso o usuario afaste o petisco da area de atuacao dos dois pontos, o sprites do 
             cachorro e as interacoes sao resetadas para seus estados iniciais*/
            
        }else{ //fecha o if do main_region
            let newTexture = SKTexture(image: #imageLiteral(resourceName: "dog"))
            self.cachorro?.texture = newTexture
            self.podeInterceptarPonto1 = true
            self.podeInterceptarPonto2 = false
        }

        
        
        
    }
    
    
    


    
    
}
