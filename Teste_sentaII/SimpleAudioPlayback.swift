//
//  SimpleAudioPlayback.swift
//  Teste_sentaII
//
//  Created by Edson  Jr on 17/10/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class SimpleAudioPlayBack {
    
    
    static let sharedPlayback = SimpleAudioPlayBack()
    private var audioPlayer: AVAudioPlayer?
    
    func playAudio_Senta(source: String,type: String){
        do {
            let aSound = URL(fileURLWithPath: Bundle.main.path(forResource: source, ofType: type)!)
            audioPlayer = try AVAudioPlayer(contentsOf: aSound)
            audioPlayer!.prepareToPlay()
            audioPlayer?.numberOfLoops = 0
            audioPlayer!.play()
            print("[SimpleAudioPlayback]: Tocando...")
            
        }catch{
            print("[SimpleAudioPlayback]: Erro ao iniciar player ou arquivo de audio nao encontrado!")
        }
    }
    
    
    
    
    func stop() {
        audioPlayer?.stop()
    }
    
    
    
}
