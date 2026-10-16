import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var culturas: [Cultura] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Culturas del Perú"

        culturas = [
            Cultura(nombre: "Caral", region: "Lima (valle de Supe)",
                    descripcion: "Considerada la civilización más antigua de América, con unos 5000 años. Construyó grandes pirámides y plazas ceremoniales.",
                    imagen: "caral"),
            Cultura(nombre: "Chavín", region: "Áncash",
                    descripcion: "Cultura andina con un gran centro ceremonial en Chavín de Huántar, famosa por su arte en piedra y su deidad con rasgos de felino.",
                    imagen: "chavin"),
            Cultura(nombre: "Paracas", region: "Ica",
                    descripcion: "Cultura de la costa sur, conocida por sus textiles bordados y por sus necrópolis con fardos funerarios.",
                    imagen: "paracas"),
            Cultura(nombre: "Nazca", region: "Ica",
                    descripcion: "Cultura de la costa sur famosa por sus geoglifos en el desierto, su cerámica policromada y sus acueductos.",
                    imagen: "nazca"),
            Cultura(nombre: "Moche", region: "La Libertad y Lambayeque",
                    descripcion: "Cultura de la costa norte que construyó grandes huacas de adobe y fue célebre por su cerámica y su orfebrería.",
                    imagen: "moche"),
            Cultura(nombre: "Inca", region: "Cusco",
                    descripcion: "El imperio más grande de América del Sur, con capital en el Cusco. Construyó caminos, ciudadelas y terrazas agrícolas.",
                    imagen: "inca")
        ]

        // Conecta la tabla por código (por si la conexión del storyboard falta)
        let tabla = view.subviews.compactMap { $0 as? UITableView }.first
        tabla?.dataSource = self
        tabla?.delegate = self
        tabla?.reloadData()
    }

    // MARK: - Table view

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return culturas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as? CulturaTableViewCell else {
            return UITableViewCell()
        }
        let cultura = culturas[indexPath.row]
        celda.culturaImagen.image = UIImage(named: cultura.imagen)
        celda.culturaNombre.text = cultura.nombre
        celda.culturaRegion.text = cultura.region
        return celda
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "mostrarDetalle", sender: culturas[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarDetalle",
           let destino = segue.destination as? DetalleCulturaViewController,
           let cultura = sender as? Cultura {
            destino.cultura = cultura
        }
    }
}
