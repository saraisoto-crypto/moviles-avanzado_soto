//
//  UITextField+VerClave.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Extensión reutilizable: agrega un botón de "ojo" 👁 dentro del campo
//  para mostrar u ocultar la contraseña. Se usa en Login y en Registro.
//

import UIKit

extension UITextField {

    /// Coloca un botón con ícono de ojo al lado derecho del campo.
    /// Al tocarlo alterna isSecureTextEntry (puntos ↔ texto visible)
    /// y cambia el ícono según el estado.
    func agregarBotonVerClave() {
        let boton = UIButton(type: .system)
        boton.setImage(UIImage(systemName: "eye"), for: .normal)
        boton.tintColor = .secondaryLabel

        // UIAction con closure: al tocar el ojo se alterna la visibilidad
        boton.addAction(UIAction { [weak self, weak boton] _ in
            guard let self, let boton else { return }
            self.isSecureTextEntry.toggle()
            // eye = clave oculta (tócalo para ver) | eye.slash = clave visible
            let icono = self.isSecureTextEntry ? "eye" : "eye.slash"
            boton.setImage(UIImage(systemName: icono), for: .normal)
        }, for: .touchUpInside)

        // Contenedor con margen para que el ojo no quede pegado al borde
        boton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let contenedor = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: 30))
        contenedor.addSubview(boton)

        // El botón se muestra siempre en el lado derecho del campo
        rightView = contenedor
        rightViewMode = .always
    }
}
