//
//  SCLAlertView+Extension.swift
//  Teste_sentaII
//
//  Created by Edson  Jr on 17/10/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit



extension SCLAlertView {
    
    func alertarWarning(titulo: String, textoBase: String,textoBotao: String) {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            showCircularIcon: true
        )

        let alert = SCLAlertView(appearance: appearance)
        alert.addButton(NSLocalizedString(textoBotao, comment: textoBotao), action: {
            print("[ALERT]: Botao pressionado")
            
        })

       alert.showWarning(titulo, subTitle: textoBase)
        
    }
    
 
    
    func alertarWarning(titulo: String, textoBase: String,textoBotao: String,completionHandler: @escaping () -> Void) {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            showCircularIcon: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton(NSLocalizedString(textoBotao, comment: textoBotao), action: {
            print("[ALERT]: Botao pressionado")
            completionHandler()
            
        })
        
        alert.showWarning(titulo, subTitle: textoBase)
        
    }

    
    
    
    
    
    
    
    
    
}
