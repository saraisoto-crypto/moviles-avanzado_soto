import UIKit

class ViewControllerConfirmacion: UIViewController {

    // instanciar la clase ClienteModel
    var pCliente: ClienteModel = ClienteModel()

    // definir los controles
    @IBOutlet weak var tfApellido: UILabel!
    @IBOutlet weak var tfNombre: UILabel!
    @IBOutlet weak var tfDni: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // mostrar los datos recibidos en los controles
        self.tfApellido.text = pCliente.Apellido
        self.tfNombre.text = pCliente.Nombre
        self.tfDni.text = pCliente.Dni
    }

    // Boton "Volver" (aparece en la captura del PDF)
    @IBAction func btnVolver(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
