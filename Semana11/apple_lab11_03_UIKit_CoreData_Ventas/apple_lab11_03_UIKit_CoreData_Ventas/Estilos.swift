//
//  Estilos.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Estilos compartidos de la app: color principal, vista con degradado
//  y estilo de campos de texto. Centralizarlos aquí hace que toda
//  la app se vea consistente y sea fácil de cambiar.
//

import UIKit

enum Estilos {
    /// Color principal de la marca: se usa como tint global de la ventana,
    /// así todos los botones, tabs e íconos lo heredan automáticamente
    static let colorPrimario = UIColor.systemIndigo
}

/// UIView cuya capa de respaldo es un CAGradientLayer:
/// el degradado se redimensiona solo junto con la vista (sin frames manuales)
final class VistaGradiente: UIView {

    override class var layerClass: AnyClass { CAGradientLayer.self }

    init(colores: [UIColor]) {
        super.init(frame: .zero)
        let capa = layer as! CAGradientLayer
        capa.colors = colores.map { $0.cgColor }
        // Degradado en diagonal, de arriba-izquierda a abajo-derecha
        capa.startPoint = CGPoint(x: 0, y: 0)
        capa.endPoint = CGPoint(x: 1, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) no implementado: la interfaz es por código")
    }
}

extension UITextField {

    /// Estilo "tarjeta" para campos de texto: fondo gris redondeado
    /// con un ícono SF Symbol a la izquierda (en vez del borde clásico)
    func aplicarEstiloTarjeta(icono: String) {
        borderStyle = .none
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 12
        clipsToBounds = true

        // Ícono dentro de un contenedor para darle margen interno
        let imagen = UIImageView(image: UIImage(systemName: icono))
        imagen.tintColor = .secondaryLabel
        imagen.contentMode = .scaleAspectFit
        imagen.frame = CGRect(x: 14, y: 0, width: 22, height: 22)
        let contenedor = UIView(frame: CGRect(x: 0, y: 0, width: 46, height: 22))
        contenedor.addSubview(imagen)
        leftView = contenedor
        leftViewMode = .always
    }
}
