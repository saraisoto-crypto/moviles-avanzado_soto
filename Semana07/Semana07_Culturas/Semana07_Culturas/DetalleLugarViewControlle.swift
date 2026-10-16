import UIKit

class DetalleLugarViewController: UIViewController {

    @IBOutlet weak var lugarImagen: UIImageView!
    @IBOutlet weak var lugarNombre: UILabel!
    @IBOutlet weak var lugarTipo: UILabel!
    @IBOutlet weak var lugarUbicacion: UILabel!
    @IBOutlet weak var lugarDescripcion: UILabel!
    @IBOutlet weak var lugarDatoCurioso: UILabel!

    var lugar: Lugar?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let lugar = lugar else { return }

        title = lugar.nombre
        lugarImagen.image = UIImage(named: lugar.imagen) ?? UIImage(systemName: "photo")
        lugarNombre.text = lugar.nombre
        lugarTipo.text = lugar.tipo
        lugarUbicacion.text = "📍 " + lugar.ubicacion
        lugarDescripcion.text = lugar.descripcion
        lugarDatoCurioso.text = "💡 " + lugar.datoCurioso
    }
}
