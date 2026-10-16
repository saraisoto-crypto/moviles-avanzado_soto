//
//  ViewController.swift
//  apple_lab07_TableView
//
//  Created by Sarai Sthefanie Soto on 13/10/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Paso 17: lista de profesores con foto
    var profesores: [Profesor] = [
        Profesor(nombre: "Jaime Gomez", cargo: "Coordinador de software", foto: UIImage(named: "profesor1")),
        Profesor(nombre: "Jaime Farfán", cargo: "Docente de software TC", foto: UIImage(named: "profesor2")),
        Profesor(nombre: "Juan León", cargo: "Docente de software TC", foto: UIImage(named: "profesor3")),
        Profesor(nombre: "Silvia Montoya", cargo: "Docente de software TC", foto: UIImage(named: "profesor4")),
        Profesor(nombre: "Theobaldo Diaz", cargo: "Docente de software TC", foto: UIImage(named: "profesor5")),
        Profesor(nombre: "Elliot Garamendi", cargo: "Docente de software TC", foto: UIImage(named: "profesor6")),
        Profesor(nombre: "Edwin Huerto", cargo: "Docente de Redes TC", foto: UIImage(named: "profesor7"))
    ]

    // Paso 12: cantidad de filas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profesores.count
    }

    // Pasos 13 y 18: celda reutilizable con imagen
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        let profesor = profesores[indexPath.row]
        celda.textLabel?.text = profesor.nombre
        celda.detailTextLabel?.text = profesor.cargo

        // Si falta la foto en Assets, muestra un icono de persona
        let foto = profesor.foto ?? UIImage(systemName: "person.circle")
        celda.imageView?.image = redimensionar(foto, a: CGSize(width: 60, height: 60))
        celda.imageView?.layer.cornerRadius = 30
        celda.imageView?.clipsToBounds = true
        return celda
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    // Ajusta cualquier foto al tamaño indicado
    func redimensionar(_ imagen: UIImage?, a tamano: CGSize) -> UIImage? {
        guard let imagen = imagen else { return nil }
        let renderer = UIGraphicsImageRenderer(size: tamano)
        return renderer.image { _ in
            imagen.draw(in: CGRect(origin: .zero, size: tamano))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
