//
//  ViewModel.swift
//  Poke-App-Programmatically
//
//  Created by Burak Erden on 19.04.2023.
//

import Foundation

class ViewModel {
    
    //MARK: - Properties

    var pokeNamesData: (([Result]?) -> Void)?

    //MARK: - Functions
    
    func getPokeData() {
        Service().getPokeName(){ result in
            guard let data = result?.results else {return}
            self.pokeNamesData?(data)
        } onError: { error in
            print("ERROR: ", error.localizedDescription)
        }
    }
}

