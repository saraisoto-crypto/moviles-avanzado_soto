//
//  ViewController+Relacion.swift
//  apple_lab11_01_UIKit_CoreData
//
//  Filtro con NSPredicate y relación uno a muchos (Grupo → Contactos).
//

import UIKit
import CoreData

extension ViewController {

    // fetch request con predicate simple: buscar por texto en el nombre
    func buscarContactos(texto: String) -> [Contacto] {
        let request: NSFetchRequest<Contacto> = Contacto.fetchRequest()
        request.predicate = NSPredicate(format: "nombre CONTAINS[cd] %@", texto)
        request.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        return (try? conexion().fetch(request)) ?? []
    }

    // Crea un grupo y se lo asigna al primer contacto. Ejecútala UNA sola vez
    // (por ejemplo desde viewDidLoad) y luego vuelve a comentarla.
    func probarRelacion() {
        let contexto = conexion()
        let grupo = NSEntityDescription.insertNewObject(forEntityName: "Grupo", into: contexto) as! Grupo
        grupo.nombre = "Amigos"
        if let primero = contactos.first {
            primero.grupo = grupo            // El lado "uno" de la relación
        }
        do {
            try contexto.save()
            print("El grupo \(grupo.nombre ?? "") tiene \(grupo.contactos?.count ?? 0) contacto(s)")
        } catch {
            print("Error al guardar la relación: \(error)")
        }
    }

    // fetch request con predicate que recorre la relación
    func contactosDelGrupo(_ nombreGrupo: String) -> [Contacto] {
        let request: NSFetchRequest<Contacto> = Contacto.fetchRequest()
        request.predicate = NSPredicate(format: "grupo.nombre == %@", nombreGrupo)
        return (try? conexion().fetch(request)) ?? []
    }

    // Carga los contactos de ejemplo del lab. Ejecútala UNA sola vez y luego coméntala.
    func cargarDatosDePrueba() {
        let datos = [
            ("Juan León", "986464533", "Las Begonias"),
            ("Jaime Gómez", "984747474", "Los Frutales"),
            ("Jaime Farfan", "989898987", "las Manzanas"),
            ("Silvia Montoya", "989797979", "Las Declicias"),
            ("Luis Diaz", "987635342", "Los Arandanos"),
            ("Maria Vizcarra", "987463539", "Los Claves"),
            ("Jose Morales", "987654234", "Las Vias"),
            ("Jessica Diaz", "989767689", "Loas Nogales"),
            ("Jose Quiñones", "987654321", "Las Frutas"),
            ("Patricia Zuta", "978767987", "Los Mangos"),
            ("Jose Perez", "987594873", "Las Manzanas")
        ]
        let contexto = conexion()
        for (nombre, telefono, direccion) in datos {
            let c = NSEntityDescription.insertNewObject(forEntityName: "Contacto", into: contexto) as! Contacto
            c.nombre = nombre
            c.telefono = telefono
            c.direccion = direccion
        }
        do {
            try contexto.save()
            cargarInfoCoreData()
            TablaContacto.reloadData()
        } catch {
            print("Error al cargar datos de prueba: \(error)")
        }
    }
}
