//
//  Boleta_swiftApp.swift
//  Boleta.swift
//
//  Created by Sarai Sthefanie Soto on 28/10/26.
//

import SwiftUI

@main
struct Boleta_swiftApp: App {

    init() {
        #if DEBUG
        CasosPrueba.verificar()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
