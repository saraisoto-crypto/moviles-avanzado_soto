import UIKit

class DetalleCulturaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var detalleImagen: UIImageView!
    @IBOutlet weak var detalleNombre: UILabel!
    @IBOutlet weak var detalleRegion: UILabel!
    @IBOutlet weak var detalleDescripcion: UILabel!
    @IBOutlet weak var lugaresTableView: UITableView?

    var cultura: Cultura?
    var lugares: [Lugar] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let cultura = cultura {
            detalleImagen.image = UIImage(named: cultura.imagen)
            detalleNombre.text = cultura.nombre
            detalleRegion.text = cultura.region
            detalleDescripcion.text = cultura.descripcion

            lugares = cultura.lugares.isEmpty
                ? DatosLugares.lugares(para: cultura.nombre)
                : cultura.lugares
        }

        let tabla = lugaresTableView ?? view.subviews.compactMap { $0 as? UITableView }.first
        tabla?.dataSource = self
        tabla?.delegate = self
        tabla?.reloadData()
    }

    // MARK: - Table view

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lugares.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celda = tableView.dequeueReusableCell(withIdentifier: "celdaLugar", for: indexPath) as? LugarTableViewCell else {
            return UITableViewCell()
        }
        let lugar = lugares[indexPath.row]
        celda.lugarNombre.text = lugar.nombre
        celda.lugarTipo.text = lugar.tipo
        return celda
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "mostrarLugar", sender: lugares[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarLugar",
           let destino = segue.destination as? DetalleLugarViewController,
           let lugar = sender as? Lugar {
            destino.lugar = lugar
        }
    }
}
