import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tablaPersonas: UITableView!

    // Arreglos con los nombres e imágenes
    var personasArreglo = ["Jaime Gomez", "Juan León", "Silvia Montoya", "Theo Diaz", "Elliot Garamendi"]
    var personasImagenarreglo = ["avatar1", "avatar2", "avatar3", "avatar4", "avatar5"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Cantidad de filas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personasArreglo.count
    }

    // Contenido de cada celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "miCell") as? PersonasTableViewCell else {
            print("⚠️ La celda no es PersonasTableViewCell: revisa Custom Class e Identifier en el storyboard")
            return UITableViewCell()
        }
        cell.personaNombre.text = personasArreglo[indexPath.row]
        cell.PersonaImagen.image = UIImage(named: personasImagenarreglo[indexPath.row])
        return cell
    }

    // Alerta al seleccionar una persona (pasos 10 y 11)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alerta = UIAlertController(
            title: "Persona seleccionada",
            message: "Seleccionaste a \(personasArreglo[indexPath.row])",
            preferredStyle: .alert
        )
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
