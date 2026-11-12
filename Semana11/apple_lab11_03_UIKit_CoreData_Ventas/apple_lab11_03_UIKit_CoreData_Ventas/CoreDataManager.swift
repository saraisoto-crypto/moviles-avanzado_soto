//
//  CoreDataManager.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Gestor central de Core Data. Centraliza el acceso al contexto,
//  el guardado con manejo de errores y la precarga de datos de prueba.
//

import UIKit
import CoreData

final class CoreDataManager {

    // Patrón Singleton: una única instancia compartida en toda la app
    static let shared = CoreDataManager()
    private init() {}

    /// Contexto principal de Core Data.
    /// IMPORTANTE: se obtiene del persistentContainer definido en AppDelegate
    /// (requisito del laboratorio: usar el stack que ya viene con el proyecto).
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    /// Guarda los cambios pendientes del contexto.
    /// - Returns: true si guardó correctamente, false si hubo error.
    /// Si falla (por ejemplo, al eliminar un registro protegido por la regla
    /// de borrado "Deny"), se hace rollback() para revertir los cambios
    /// y dejar el contexto en un estado consistente.
    @discardableResult
    func guardar() -> Bool {
        do {
            if context.hasChanges {
                try context.save()
            }
            return true
        } catch {
            print("Error al guardar en Core Data: \(error)")
            context.rollback() // revierte los cambios no guardados
            return false
        }
    }

    /// Inserta datos de prueba SOLO la primera vez que se ejecuta la app.
    /// Se verifica contando los usuarios: si ya existen, no se vuelve a insertar.
    func precargarDatosSiEsNecesario() {
        let solicitud: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        let cantidad = (try? context.count(for: solicitud)) ?? 0
        guard cantidad == 0 else { return } // ya hay datos, no precargamos

        // ---- Usuarios iniciales (uno por cada rol) ----
        let supervisor = Usuario(context: context)
        supervisor.nombre = "Administrador General"
        supervisor.usuario = "admin"
        supervisor.clave = "admin123"
        supervisor.rol = "Supervisor"

        let vendedor = Usuario(context: context)
        vendedor.nombre = "Juan Pérez"
        vendedor.usuario = "jperez"
        vendedor.clave = "1234"
        vendedor.rol = "Vendedor"

        // ---- Productos iniciales ----
        let datosProductos: [(String, String, Double, Int64)] = [
            ("Laptop HP 15", "Cómputo", 2500.00, 10),
            ("Mouse Logitech M170", "Accesorios", 80.00, 50),
            ("Teclado Mecánico Redragon", "Accesorios", 180.00, 30),
            ("Monitor LG 24\"", "Cómputo", 650.00, 15)
        ]
        for (nombre, categoria, precio, stock) in datosProductos {
            let producto = Producto(context: context)
            producto.nombre = nombre
            producto.categoria = categoria
            producto.precio = precio
            producto.stock = stock
        }

        // ---- Clientes iniciales ----
        let datosClientes: [(String, String)] = [
            ("María López", "45678912"),
            ("Carlos Ruiz", "87654321"),
            ("Ana Torres", "12345678")
        ]
        for (nombre, documento) in datosClientes {
            let cliente = Cliente(context: context)
            cliente.nombre = nombre
            cliente.documento = documento
        }

        guardar()
        print("Datos de prueba precargados correctamente")
    }
}
