//
//  Sesion.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Maneja la sesión del usuario logueado en toda la app.
//  Es un Singleton: una única instancia compartida a la que
//  cualquier pantalla puede consultar quién inició sesión.
//

import Foundation

class Sesion {

    // Instancia única compartida (patrón Singleton)
    static let compartida = Sesion()

    // El constructor es privado para que nadie cree otra instancia
    private init() {}

    // Usuario que inició sesión. Es nil cuando no hay sesión activa
    // (al abrir la app o después de "Cerrar sesión").
    var usuarioActual: Usuario?
}
