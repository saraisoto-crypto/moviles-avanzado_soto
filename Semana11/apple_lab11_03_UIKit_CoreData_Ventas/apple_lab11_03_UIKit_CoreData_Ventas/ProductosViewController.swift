//
//  ProductosViewController.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Pantalla A3: catálogo de productos.
//  - El VENDEDOR solo consulta; el SUPERVISOR puede crear (+), editar
//    (tocar la fila) y eliminar (deslizar)
//  - UISearchBar para buscar por nombre
//  - "Chips" de categoría que filtran usando NSPredicate en el fetch
//  - Stock con color semáforo: verde > 10, ámbar 6–10, rojo ≤ 5
//  - La regla Deny impide borrar un producto con ventas (alerta)
//

import UIKit
import CoreData

class ProductosViewController: UIViewController,
                               UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    // MARK: - Componentes de la interfaz

    private let buscador: UISearchBar = {
        let buscador = UISearchBar()
        buscador.placeholder = "Buscar producto por nombre"
        buscador.searchBarStyle = .minimal
        return buscador
    }()

    // Franja horizontal con los chips de categoría
    private let scrollChips = UIScrollView()
    private let pilaChips = UIStackView()
    private let tabla = UITableView()

    // MARK: - Datos

    private var productos: [Producto] = []       // resultado del fetch filtrado
    private var categorias: [String] = []        // categorías únicas para los chips
    private var categoriaSeleccionada: String?   // nil = chip "Todas"

    // Control por rol: solo el Supervisor administra el catálogo
    private var esSupervisor: Bool {
        Sesion.compartida.usuarioActual?.rol == "Supervisor"
    }

    // MARK: - Ciclo de vida

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Productos"
        view.backgroundColor = .systemBackground

        // El botón "+" SOLO existe para el Supervisor
        if esSupervisor {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .add, target: self, action: #selector(agregarProducto))
        }

        configurarInterfaz()
        tabla.dataSource = self
        tabla.delegate = self
        buscador.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Se recarga al entrar (el stock cambia cuando se venden productos)
        cargarProductos()
    }

    // MARK: - Auto Layout por código

    private func configurarInterfaz() {
        scrollChips.showsHorizontalScrollIndicator = false
        pilaChips.axis = .horizontal
        pilaChips.spacing = 8

        buscador.translatesAutoresizingMaskIntoConstraints = false
        scrollChips.translatesAutoresizingMaskIntoConstraints = false
        pilaChips.translatesAutoresizingMaskIntoConstraints = false
        tabla.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buscador)
        view.addSubview(scrollChips)
        scrollChips.addSubview(pilaChips)
        view.addSubview(tabla)

        NSLayoutConstraint.activate([
            // Buscador arriba
            buscador.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buscador.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            buscador.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            // Chips debajo del buscador
            scrollChips.topAnchor.constraint(equalTo: buscador.bottomAnchor, constant: 4),
            scrollChips.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollChips.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollChips.heightAnchor.constraint(equalToConstant: 40),
            pilaChips.topAnchor.constraint(equalTo: scrollChips.contentLayoutGuide.topAnchor),
            pilaChips.bottomAnchor.constraint(equalTo: scrollChips.contentLayoutGuide.bottomAnchor),
            pilaChips.leadingAnchor.constraint(equalTo: scrollChips.contentLayoutGuide.leadingAnchor, constant: 16),
            pilaChips.trailingAnchor.constraint(equalTo: scrollChips.contentLayoutGuide.trailingAnchor, constant: -16),
            pilaChips.heightAnchor.constraint(equalTo: scrollChips.frameLayoutGuide.heightAnchor),
            // La tabla ocupa el resto
            tabla.topAnchor.constraint(equalTo: scrollChips.bottomAnchor, constant: 4),
            tabla.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabla.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabla.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - LEER con filtros (NSPredicate)

    private func cargarProductos() {
        let contexto = CoreDataManager.shared.context

        // 1) Categorías únicas (sobre TODOS los productos) para armar los chips
        let solicitudTodas: NSFetchRequest<Producto> = Producto.fetchRequest()
        let todos = (try? contexto.fetch(solicitudTodas)) ?? []
        var vistas = Set<String>()
        categorias = todos
            .compactMap { $0.categoria }
            .filter { vistas.insert($0).inserted } // únicas conservando orden
            .sorted()
        // Si la categoría filtrada ya no existe, volvemos a "Todas"
        if let categoria = categoriaSeleccionada, !categorias.contains(categoria) {
            categoriaSeleccionada = nil
        }
        reconstruirChips()

        // 2) Fetch FILTRADO: los filtros se arman como NSPredicate
        let solicitud: NSFetchRequest<Producto> = Producto.fetchRequest()
        solicitud.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]

        var predicados: [NSPredicate] = []
        // Búsqueda por nombre: CONTAINS[cd] = contiene, sin mayúsculas ni tildes
        let texto = (buscador.text ?? "").trimmingCharacters(in: .whitespaces)
        if !texto.isEmpty {
            predicados.append(NSPredicate(format: "nombre CONTAINS[cd] %@", texto))
        }
        // Chip de categoría activo
        if let categoria = categoriaSeleccionada {
            predicados.append(NSPredicate(format: "categoria ==[c] %@", categoria))
        }
        // Se combinan con AND (si no hay filtros, el predicate queda nil = todos)
        if !predicados.isEmpty {
            solicitud.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicados)
        }

        productos = (try? contexto.fetch(solicitud)) ?? []
        tabla.reloadData()
        actualizarEstadoVacio()
    }

    // MARK: - Chips de categoría

    private func reconstruirChips() {
        pilaChips.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Chip "Todas" (tag 0) + un chip por categoría (tag = índice + 1)
        pilaChips.addArrangedSubview(crearChip(titulo: "Todas", tag: 0, activo: categoriaSeleccionada == nil))
        for (indice, categoria) in categorias.enumerated() {
            pilaChips.addArrangedSubview(crearChip(
                titulo: categoria, tag: indice + 1, activo: categoriaSeleccionada == categoria))
        }
    }

    private func crearChip(titulo: String, tag: Int, activo: Bool) -> UIButton {
        var configuracion = activo ? UIButton.Configuration.filled() : UIButton.Configuration.gray()
        configuracion.title = titulo
        configuracion.cornerStyle = .capsule
        configuracion.buttonSize = .small
        let boton = UIButton(configuration: configuracion)
        boton.tag = tag
        boton.addTarget(self, action: #selector(chipTocado(_:)), for: .touchUpInside)
        return boton
    }

    @objc private func chipTocado(_ boton: UIButton) {
        categoriaSeleccionada = boton.tag == 0 ? nil : categorias[boton.tag - 1]
        cargarProductos() // vuelve a consultar con el nuevo predicate
    }

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cargarProductos() // filtra en vivo mientras se escribe
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    // MARK: - CREAR y ACTUALIZAR (solo Supervisor)

    @objc private func agregarProducto() {
        mostrarFormulario(producto: nil) // nil = modo "crear"
    }

    private func mostrarFormulario(producto: Producto?) {
        let esNuevo = (producto == nil)
        let alerta = UIAlertController(
            title: esNuevo ? "Nuevo Producto" : "Editar Producto",
            message: nil, preferredStyle: .alert)

        alerta.addTextField { campo in
            campo.placeholder = "Nombre"
            campo.text = producto?.nombre
        }
        alerta.addTextField { campo in
            campo.placeholder = "Categoría"
            campo.text = producto?.categoria
        }
        alerta.addTextField { campo in
            campo.placeholder = "Precio"
            campo.keyboardType = .decimalPad
            if let p = producto { campo.text = String(p.precio) }
        }
        alerta.addTextField { campo in
            campo.placeholder = "Stock"
            campo.keyboardType = .numberPad
            if let p = producto { campo.text = String(p.stock) }
        }

        alerta.addAction(UIAlertAction(title: "Guardar", style: .default) { [weak self] _ in
            guard let self else { return }

            let nombre = alerta.textFields?[0].text ?? ""
            let categoria = alerta.textFields?[1].text ?? ""
            // El teclado decimal en español usa coma; la cambiamos por punto
            let textoPrecio = (alerta.textFields?[2].text ?? "").replacingOccurrences(of: ",", with: ".")
            let textoStock = alerta.textFields?[3].text ?? ""

            guard !nombre.isEmpty, !categoria.isEmpty,
                  let precio = Double(textoPrecio), precio >= 0,
                  let stock = Int64(textoStock), stock >= 0 else {
                self.mostrarAlerta(mensaje: "Datos inválidos. Revisa nombre, categoría, precio y stock.")
                return
            }

            // Nuevo → se inserta; existente → se modifica
            let objetivo = producto ?? Producto(context: CoreDataManager.shared.context)
            objetivo.nombre = nombre
            objetivo.categoria = categoria
            objetivo.precio = precio
            objetivo.stock = stock

            CoreDataManager.shared.guardar()
            self.cargarProductos()
        })
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alerta, animated: true)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaProducto")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "celdaProducto")
        let producto = productos[indexPath.row]

        celda.imageView?.image = UIImage(systemName: "shippingbox.fill")
        celda.imageView?.tintColor = Estilos.colorPrimario
        celda.textLabel?.text = producto.nombre
        celda.textLabel?.font = .systemFont(ofSize: 17, weight: .semibold)

        // Detalle con el stock COLOREADO según el semáforo
        let detalle = NSMutableAttributedString(
            string: String(format: "%@ | S/ %.2f | ", producto.categoria ?? "", producto.precio),
            attributes: [.foregroundColor: UIColor.secondaryLabel])
        detalle.append(NSAttributedString(
            string: "Stock: \(producto.stock)",
            attributes: [
                .foregroundColor: colorStock(producto.stock),
                .font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ]))
        celda.detailTextLabel?.attributedText = detalle

        // El vendedor no edita: sin resaltado al tocar
        celda.selectionStyle = esSupervisor ? .default : .none
        return celda
    }

    /// Semáforo de stock: verde > 10, ámbar 6–10, rojo ≤ 5
    private func colorStock(_ stock: Int64) -> UIColor {
        if stock > 10 { return .systemGreen }
        if stock >= 6 { return .systemOrange }
        return .systemRed
    }

    // MARK: - UITableViewDelegate

    // Tocar una fila: solo el Supervisor abre el formulario de edición
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard esSupervisor else { return } // el vendedor solo consulta
        mostrarFormulario(producto: productos[indexPath.row])
    }

    // El deslizar-para-borrar SOLO existe para el Supervisor
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return esSupervisor
    }

    // MARK: - ELIMINAR (protegido por la regla Deny)

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let producto = productos[indexPath.row]
        CoreDataManager.shared.context.delete(producto)

        // La regla "Deny" hace que save() FALLE si el producto tiene ventas;
        // guardar() hace rollback y devuelve false
        if CoreDataManager.shared.guardar() {
            productos.remove(at: indexPath.row)
            tabla.deleteRows(at: [indexPath], with: .automatic)
            actualizarEstadoVacio()
        } else {
            mostrarAlerta(mensaje: "No se puede eliminar \"\(producto.nombre ?? "")\": tiene ventas registradas (regla Deny).")
        }
    }

    // MARK: - Utilitarios

    // Mensaje central cuando la tabla está vacía
    private func actualizarEstadoVacio() {
        if productos.isEmpty {
            let etiqueta = UILabel()
            etiqueta.text = "📦\n\nNo se encontraron productos."
            etiqueta.numberOfLines = 0
            etiqueta.textAlignment = .center
            etiqueta.textColor = .secondaryLabel
            etiqueta.font = .systemFont(ofSize: 17)
            tabla.backgroundView = etiqueta
        } else {
            tabla.backgroundView = nil
        }
    }

    private func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Atención", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
}
