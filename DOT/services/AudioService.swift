//
//  AudioService.swift
//  DOT
//
//  Created by Martin Nava on 19/06/24.
//

import Foundation
import Speech

class AudioService: ObservableObject {
    var deviceAuthorized = false
    @Published var transcription = "Presiona el botón para empezar a escucharte."
    
    //Variables for audio processing
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "es-MX"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var audioEngine = AVAudioEngine()
    private var recognitionTask: SFSpeechRecognitionTask?
    
    //Variables to control when recording is done
    private var isStopping = false
    private var silenceTimer: Timer?
    @Published var isRecording = false
    
    public func startRecording() {
        if !deviceAuthorized {
            transcription = "Por favor, dame acceso al reconocimiento de voz y al micrófono."
            return
        }
        
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            print("El reconocedor de voz no está disponible")
            return
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            fatalError("No se pudo crear una solicitud de reconocimiento")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.record, mode: .measurement, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("No se pudieron configurar las propiedades de la sesión de audio debido a un error.")
            return
        }
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("El motor de audio no pudo arrancar debido a un error: \(error).")
            return
        }
        
        isStopping = false
        recognitionTask = recognizer.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                if result.isFinal {
                    self.stopRecording(message: "Estoy procesando tu solicitud...")
                } else {
                    self.restartSilenceTimer()
                    self.transcription = result.bestTranscription.formattedString
                }
            }
            
            if let error = error {
                print("Error de reconocimiento: \(error)")
                self.stopRecording(message: nil)
            }
        }
        
        transcription = "¡Te estoy escuchando!"
        isRecording = true
        startSilenceTimer()
    }
    
    public func stopRecording(message: String?) {
        if let message = message {
            self.transcription = message
        }
        
        guard !isStopping else {
            return
        }
        
        isStopping = true
        
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        recognitionTask = nil
        
        isRecording = false
        silenceTimer?.invalidate()
        silenceTimer = nil
    }
    
    private func startSilenceTimer() {
        silenceTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            self.stopRecording(message: nil)
        }
    }
    
    private func restartSilenceTimer() {
        silenceTimer?.invalidate()
        startSilenceTimer()
    }
}
