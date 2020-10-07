//
//  ContentView.swift
//  babylone
//
//  Created by Axel Tringa on 2020-10-06.
//

import SwiftUI
import CoreML
import NaturalLanguage

struct ContentView: View {
    @State var langues = ""
    var body: some View {
        ZStack{
            Rectangle()
                .fill()
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                
            VStack{
                Text("\(self.detecterLangage(dialecte: langues)!)")
                    .foregroundColor(.white)
                    .bold()
                    .font(.callout)
                TextField("", text: self.$langues)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 350)
                Button(action: {
                    if let lang = self.detecterLangage(dialecte: langues) {
                        self.langues = lang
                    }
                }){
                    Text("Détecter")
                        .foregroundColor(.white)
                }
                .frame(width: 100,height: 50)
                .background(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)))
                .cornerRadius(35)
            }
        }
        
    }
    func detecterLangage(dialecte: String) -> String? {
        let local = Locale(identifier: "fr")
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(dialecte)
        guard let langages = recognizer.dominantLanguage
        else {return "Impossible de reconnaitre le langage"}
        return local.localizedString(forLanguageCode: langages.rawValue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
