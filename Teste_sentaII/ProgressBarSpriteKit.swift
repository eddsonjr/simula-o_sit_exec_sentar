//
//  ProgressBar.swift
//  SpriteKitProgressBar
//
//  Created by Edson  Jr on 27/10/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit


class ProgressBarSpriteKit {
    
    
    private var progressBarOutline = SKShapeNode()
    private var insideShapeProgressBar = SKShapeNode()
    
    
    //Construtor
    init(rect: CGRect, lineColor: UIColor, progressBarColor: UIColor) {
      
        //Criando a outline da barra de progresso
        self.progressBarOutline.path = UIBezierPath(roundedRect: rect, cornerRadius: 4).cgPath
        self.progressBarOutline.fillColor = UIColor.clear
        self.progressBarOutline.strokeColor = lineColor
        self.progressBarOutline.lineWidth = 2
        
        
        //criando o preenchimento da barra de progresso
        self.insideShapeProgressBar.path = UIBezierPath(roundedRect: CGRect(x: self.progressBarOutline.frame.minX+2.75, y: self.progressBarOutline.frame.minY+2.75, width: 0, height: self.progressBarOutline.frame.height-5), cornerRadius: 4).cgPath
        self.insideShapeProgressBar.fillColor = progressBarColor
        self.insideShapeProgressBar.strokeColor = UIColor.clear
        self.insideShapeProgressBar.lineWidth = 0
        
        
    }
    
    
    //Adquirindo os shapes para adicionar na barra de progresso
    func getProgressBarSpriteKitShapes() -> (SKShapeNode,SKShapeNode){
        let tuplaDeShapes = (self.progressBarOutline,self.insideShapeProgressBar)
        return tuplaDeShapes
    
    }
    
    
    
    
    //Funcao para rendereizar o interior da barra de progresso
    func renderizarProgresso(montante: CGFloat) {
         let montanteRenderizacao = montante - 3.0
         self.insideShapeProgressBar.path = UIBezierPath(roundedRect: CGRect(x: progressBarOutline.frame.minX+2.75, y: progressBarOutline.frame.minY+2.75, width: montanteRenderizacao, height: progressBarOutline.frame.height-5), cornerRadius: 1).cgPath
    }
    
    
    
    
    //Atualiza  o progresso da barra
    func atualizarProgressoBarra(porcengatem: CGFloat) {
        let montanteRenderizacao = ((self.progressBarOutline.frame.width*porcengatem)/100)
        print(montanteRenderizacao)
        renderizarProgresso(montante: montanteRenderizacao)
        
    }
    
    
}
