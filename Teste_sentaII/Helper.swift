//
//  Helper.swift
//  Teste_sentaII
//
//  Created by Edson  Jr on 16/10/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit



/*Enum contendo as fases de treinamento do exercicio*/
enum trainStage: Int {
    case somenteComPetisco = 0
    case somenteComVoz = 1
    case comVozEGesto = 2
    case treinamentoCompletado = 3
}



class Helper {

    static var tamanhoBarraDeProgresso: Float = 0
    static var porcentagemGeralDoPrgoresso: Float = 0
    
    
    //Armazena o estagio de treinamento do cachorro
    static var estagioTreinamento: Int = trainStage.somenteComPetisco.rawValue
    
    

    static var treinarSomenteComVoz: Bool = false
    static var treinarComGestoVoz: Bool = false
    
    
}
