import Foundation

class Lugar: NSObject {

    var nombre: String
    var tipo: String
    var ubicacion: String
    var descripcion: String
    var datoCurioso: String
    var imagen: String

    init(nombre: String,
         tipo: String,
         ubicacion: String,
         descripcion: String,
         datoCurioso: String,
         imagen: String) {
        self.nombre = nombre
        self.tipo = tipo
        self.ubicacion = ubicacion
        self.descripcion = descripcion
        self.datoCurioso = datoCurioso
        self.imagen = imagen
    }
}
