//
//  PrincipalTabBarController.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  TabBar principal de la app. Las pestañas dependen del ROL
//  del usuario logueado (guardado en Sesion):
//  - Vendedor:   Productos | Clientes | Venta | Mis ventas | Cuenta
//  - Supervisor: Resumen | Ventas | Productos | Clientes | Cuenta
//

import UIKit

class PrincipalTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rol = Sesion.compartida.usuarioActual?.rol ?? "Vendedor"

        if rol == "Supervisor" {
            // El supervisor supervisa: resumen gerencial y todas las ventas
            viewControllers = [
                crearPestana(ResumenViewController(), titulo: "Resumen", icono: "chart.bar.fill"),
                crearPestana(VentasViewController(), titulo: "Ventas", icono: "list.bullet.rectangle.fill"),
                crearPestana(ProductosViewController(), titulo: "Productos", icono: "shippingbox.fill"),
                crearPestana(ClientesViewController(), titulo: "Clientes", icono: "person.2.fill"),
                crearPestana(CuentaViewController(), titulo: "Cuenta", icono: "person.circle.fill")
            ]
        } else {
            // El vendedor opera: registra ventas y consulta las suyas
            viewControllers = [
                crearPestana(ProductosViewController(), titulo: "Productos", icono: "shippingbox.fill"),
                crearPestana(ClientesViewController(), titulo: "Clientes", icono: "person.2.fill"),
                crearPestana(RegistrarVentaViewController(), titulo: "Venta", icono: "cart.fill.badge.plus"),
                crearPestana(MisVentasViewController(), titulo: "Mis ventas", icono: "list.clipboard.fill"),
                crearPestana(CuentaViewController(), titulo: "Cuenta", icono: "person.circle.fill")
            ]
        }
    }

    // Envuelve cada pantalla en un UINavigationController (para tener
    // barra de título y poder navegar) y le asigna su ícono de pestaña
    private func crearPestana(_ controlador: UIViewController, titulo: String, icono: String) -> UINavigationController {
        let navegacion = UINavigationController(rootViewController: controlador)
        navegacion.tabBarItem = UITabBarItem(
            title: titulo,
            image: UIImage(systemName: icono),
            selectedImage: UIImage(systemName: icono))
        return navegacion
    }
}
