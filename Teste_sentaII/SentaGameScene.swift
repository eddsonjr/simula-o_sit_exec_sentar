//
//  GameScene.swift
//  Teste_sentaII
//
//  Created by Edson  Jr on 16/10/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import SpriteKit
import GameplayKit



class SentaGameScene: SKScene {
    
    
    //Sprites do treinamento com o petisco e/sem voz
    var petisco: SKSpriteNode?
    var cachorro: SKSpriteNode?
    var ponto_sentar: SKSpriteNode? //este ponto determina quando o cachorro ira sentar
    var ponto_cabeca: SKSpriteNode? //este ponto determina quando o cachorro ira olhar para cima
    var main_region: SKSpriteNode? //ponto geral que abrange ambos os pontos de intersecao
    
    
    //Sprites do treinamento com voz e gesto
    var mao: SKSpriteNode?
    
    
    //Label que indica a quantidade de exercicios a serem feitos
    var label_qtTentativas: SKLabelNode?
    
    
    //Booleanos de controler da logica da passagem pelos pontos
    var podeInterceptarPonto2: Bool = false
    var podeInterceptarPonto1: Bool = true
    var quantidadeDeTentativasAntesTreino: Int = 0
  
    
    //Variavel de alerta
    var alerta: SCLAlertView = SCLAlertView()
    
    
    
    
    override func didMove(to view: SKView){
        
        print("In didMove")
    
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
          
        
            
            if SentaHelper.estagioTreinamento == SentatrainStage.somenteComPetisco.rawValue || SentaHelper.estagioTreinamento == SentatrainStage.somenteComVoz.rawValue {
                self.petisco?.position = location
                
               treinamentoComOuSemVoz()
            
            }else if SentaHelper.estagioTreinamento == SentatrainStage.comVozEGesto.rawValue {
                self.mao?.position = location
                
                print("TOUCHES MOVED Treinamento com voz e gesto")
                treinamentoComVozEGesto()
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
        
        
        if SentaHelper.estagioTreinamento == SentatrainStage.somenteComPetisco.rawValue || SentaHelper.estagioTreinamento ==  SentatrainStage.somenteComVoz.rawValue {
             self.animacaoPetiscoRetornar()
        }else{
            self.animacaoMaoRetornar()
        }
        
       
        
    }
    
    
    
    /*Esta funcao verifica a etapa atual do treinamento e realiza configuracoes de sprites e mensagens
     a serem exibidas*/
    func verificarEtapaTreinamento() {
        
        switch SentaHelper.estagioTreinamento {
            case SentatrainStage.somenteComPetisco.rawValue: //treinamento somente com o petisco
                
                configurarSpritesNaCena()
            
            case SentatrainStage.somenteComVoz.rawValue: //treinamento com petisco e voz
            
                configurarSpritesNaCena()
                
                //coloque aqui os elementos responsaveis por ter qeu gerir o treinamento com voz
                print("[GameScene]: TEM QUE TREINAR COM VOZ")
                alerta.alertarWarning(titulo: "Treinar com comando voz", textoBase: "Agora treine o seu animal dando o comando de voz", textoBotao: "OK")

            case SentatrainStage.comVozEGesto.rawValue: //treinamento com voz e gesto
            
                configurarSpritesNaCena()
             
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
        SimpleAudioPlayBack.sharedPlayback.playAudio_Senta(source: "latidoPos", type: "mp3")
        
    }
    
    
    
    
    //Animacao de fazer o petisco voltar
    func animacaoPetiscoRetornar() {
        
        let moveAnimation = SKAction.move(to: CGPoint(x: 304, y: 143), duration: 2)
        self.petisco?.run(moveAnimation)
        
    }
    
    
    
    //Animacao de fazer a mao voltar
    func animacaoMaoRetornar() {
        let moveAnimation = SKAction.move(to: CGPoint(x: -145, y: -155), duration: 2)
        self.mao?.run(moveAnimation)

    }

    
    
    
    
    /*Esta funcao e responsavel por gerenciar o treinamento nas duas primeiras etapas, tanto somente com o petisco quanto com o petisco e o som*/
    func treinamentoComOuSemVoz() {
        
        
        /*Verifica se o usuario esta com o petisco dentro da area de atuacao dos dois pontos que ele
          tem que passar */
        if (self.petisco!.intersects(self.main_region!)) {
            print("Entrou na main_region")
            
            print("Pontos de intercepcao: ponto1>> \(self.podeInterceptarPonto1) || ponto2>> \(self.podeInterceptarPonto2)")
            
            
            
            
            /*Caso o usuario tenha interceptado o ponto 1, ele troca o sprite e permite o toque
             no segundo ponto, caso contrario, ele volta para o sprite do cachorro normal, trava
             o ponto dele sentar e volta o sprite para o cachorro em pe*/
            if ((self.petisco!.intersects(self.ponto_cabeca!)) && self.podeInterceptarPonto1) {
                print("[Gamescene]: O cachoror esta olhando para cima")
                let newTexture = SKTexture(image: #imageLiteral(resourceName: "dog_look_up"))
                self.cachorro?.texture = newTexture
                self.podeInterceptarPonto2 = true
                self.podeInterceptarPonto1 = false
                
                
            }
            
            
            
            //se o usuario aproximar o petisco ainda mais proximo da cabeca do cachorro, ai sim
            //ele ira sentar
            if ((self.petisco!.intersects(self.ponto_sentar!)) && self.podeInterceptarPonto2) {
                print("Atingiu o ponto para sentar")
                
                
                self.podeInterceptarPonto2 = false //
                let newTexture = SKTexture(image: #imageLiteral(resourceName: "dog_sit"))
                self.cachorro?.texture = newTexture
                
                //Atualizando o contador de tentativas e printando na tela
                self.quantidadeDeTentativasAntesTreino = self.quantidadeDeTentativasAntesTreino + 1
                self.label_qtTentativas?.text = String(quantidadeDeTentativasAntesTreino)
                
                
                
                //verifica se tem que colocar o comando de voz
                if SentaHelper.estagioTreinamento == SentatrainStage.somenteComVoz.rawValue {
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
    
    
    
    
    /*Esta funcao serve para indicar o treinamento tanto com voz quanto com gesto*/
    func treinamentoComVozEGesto() {
        
        if (self.mao!.intersects(self.main_region!)) {
            print("Entrou na main_region - Gesto e voz")
            
            
            
            print("Pontos de intercepcao: ponto1>> \(self.podeInterceptarPonto1) || ponto2>> \(self.podeInterceptarPonto2)")
            

            
            //verificando os pontos de interecacao
            if (self.mao!.intersects(self.ponto_cabeca!)) && self.podeInterceptarPonto1 {
                print("[GameScene]: O cachorro esta olhando para cima [treinamento com gesto]")
                let newTexture = SKTexture(image: #imageLiteral(resourceName: "dog_look_up"))
                self.cachorro?.texture = newTexture
                self.podeInterceptarPonto2 = true
                self.podeInterceptarPonto1 = false
            }
            
            if ((self.mao!.intersects(self.ponto_sentar!)) && self.podeInterceptarPonto2) {
                print("Atingiu o ponto para sentar")
                
                
                self.podeInterceptarPonto2 = false
                let newTexture = SKTexture(image: #imageLiteral(resourceName: "dog_sit"))
                self.cachorro?.texture = newTexture
                
                //Atualizando o contador de tentativas e printando na tela
                self.quantidadeDeTentativasAntesTreino = self.quantidadeDeTentativasAntesTreino + 1
                self.label_qtTentativas?.text = String(quantidadeDeTentativasAntesTreino)
                
                //toca o comando
                tocarComando()
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    
                    //Condicao para treinar com o cachorro
                    if self.quantidadeDeTentativasAntesTreino == 3 {
                        
                        print("CHAMAR A TELA DE FEEDBACK AQUI")
                        
                        
                    }else {
                        self.recolocarSprites()
                    }
                    
                }) //Fecha o mainqueue

                
                
            } //fecha o if petisco intercepta ponto sentar
            

            
        } else{ //fecha o if do main_region
            let newTexture = SKTexture(image: #imageLiteral(resourceName: "dog"))
            self.cachorro?.texture = newTexture
            self.podeInterceptarPonto2 = false
            self.podeInterceptarPonto1 = true

        }

        
        
        
        

    }
    
    
    
    
    /*Esta funcao tem por obejtivo configurar os sprites na hora em que a cena é criada*/
    func configurarSpritesNaCena() {
        
       print("ESTAGIO TREINAMENTO: \(SentaHelper.estagioTreinamento)")
        
        self.cachorro = childNode(withName: "cachorro") as? SKSpriteNode
        self.label_qtTentativas = childNode(withName: "qt_Tentativas") as? SKLabelNode
        //Inicializando a label com texto 0
        self.label_qtTentativas?.text = String(self.quantidadeDeTentativasAntesTreino)
        

        /*Verificando se o treinamento esta no estagio 1 ou 2 (treinando so com petisco ou so com a
         voz)*/
        if SentaHelper.estagioTreinamento == SentatrainStage.somenteComPetisco.rawValue || SentaHelper.estagioTreinamento == SentatrainStage.somenteComVoz.rawValue {
            
             print("[GAMESCENE >STAGE<]: Treinamento com petisco e/sem voz")
            
            // configurando sprite do main_region
            self.main_region = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 165, height: 145))
            self.main_region?.alpha = 0.4
            self.main_region?.position = CGPoint(x: -181, y: -58)
            self.addChild(self.main_region!)
           
            
            
            //configurando o sprite do ponto da cabeca
            self.ponto_cabeca = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 24, height: 24))
            self.ponto_cabeca?.alpha = 0.4
            self.ponto_cabeca?.position = CGPoint(x: -115.5, y: -1.5)
            self.addChild(self.ponto_cabeca!)
            
            
            //configurando o sprite do ponto de sentar
            self.ponto_sentar = SKSpriteNode(color: UIColor.red, size: CGSize(width: 24, height: 24))
            self.ponto_sentar?.alpha = 0.4
            self.ponto_sentar?.position = CGPoint(x: -202.5, y: -23)
            self.addChild(self.ponto_sentar!)
            
            
            //Configurando o sprite do petisco
            self.petisco = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "snack")))
            self.petisco?.size = CGSize(width: 64, height: 64)
            self.petisco?.alpha = 1.0
            self.petisco?.position = CGPoint(x: 305, y: 145)
            self.addChild(self.petisco!)
            
        
        }else if SentaHelper.estagioTreinamento == SentatrainStage.comVozEGesto.rawValue {
            
            //configurando os pontos a serem passados no exercicio com o gesto
             print("[GAMESCENE >STAGE<]: Treinamento com voz e gesto")
            
            //ponto 1
            self.ponto_cabeca = SKSpriteNode(color: UIColor.red, size: CGSize(width: 24, height: 24))
            self.ponto_cabeca?.alpha = 0.5
            self.ponto_cabeca?.position = CGPoint(x: -140, y: -80)
            self.addChild(self.ponto_cabeca!)
            
            
            //ponto 2
            self.ponto_sentar = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 24, height: 24))
            self.ponto_sentar?.alpha = 0.5
            self.ponto_sentar?.position = CGPoint(x: -140, y: -20)
            self.addChild(self.ponto_sentar!)
            
            
            //configurando a regiao 
            self.main_region = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 68, height: 130))
            self.main_region?.alpha = 0.5
            self.main_region?.position = CGPoint(x: -142, y: -60)
            self.addChild(self.main_region!)
            
            
            //configurando a mao para o gesto
            self.mao = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "hand")))
            self.mao?.size = CGSize(width: 48, height: 48)
            self.mao?.position = CGPoint(x: -145, y: -155)
            self.addChild(self.mao!)

            
        }
        
        
    }


    
    
}
