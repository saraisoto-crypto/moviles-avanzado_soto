import Foundation

class Cultura: NSObject {

    var nombre: String
    var region: String
    var descripcion: String
    var imagen: String
    var lugares: [Lugar]

    init(nombre: String, region: String, descripcion: String, imagen: String, lugares: [Lugar] = []) {
        self.nombre = nombre
        self.region = region
        self.descripcion = descripcion
        self.imagen = imagen
        self.lugares = lugares
    }
}
