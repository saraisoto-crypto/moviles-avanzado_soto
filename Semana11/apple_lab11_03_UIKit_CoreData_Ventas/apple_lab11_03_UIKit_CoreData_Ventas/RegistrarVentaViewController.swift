//
//  RegistrarVentaViewController.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Registro de una venta (pestaña "Venta" del Vendedor).
//  - Producto y cliente se eligen con UIPickerView
//  - El vendedor es el usuario logueado (Sesion.compartida.usuarioActual)
//  - REGLA DE DESCUENTO: 10% automático SOLO para clientes VIP.
//    Categoría del cliente según su historial de compras NO anuladas:
//      VIP ≥ S/ 5000 | Frecuente ≥ S/ 1000 | Regular < S/ 1000
//  - IGV 18% sobre (subtotal − descuento)
//  - Si cantidad > stock: alerta y NO se registra
//

import UIKit
import CoreData

class RegistrarVentaViewController: UIViewController,
                                    UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: - Datos

    private var productos: [Producto] = []
    private var clientes: [Cliente] = []
    private var productoSeleccionado: Producto?
    private var clienteSeleccionado: Cliente?

    // Constantes de negocio
    private let tasaIGV = 0.18            // IGV peruano: 18%
    private let descuentoVIP = 0.10       // 10% solo para clientes VIP
    private let umbralVIP = 5000.0        // historial ≥ 5000 → VIP
    private let umbralFrecuente = 1000.0  // historial ≥ 1000 → Frecuente

    // MARK: - Componentes de la interfaz

    private let etiquetaVendedor: UILabel = {
        let etiqueta = UILabel()
        etiqueta.font = .systemFont(ofSize: 16, weight: .semibold)
        return etiqueta
    }()

    private let campoProducto: UITextField = {
        let campo = UITextField()
        campo.placeholder = "Selecciona un producto"
        campo.borderStyle = .roundedRect
        campo.tintColor = .clear // sin cursor: el campo solo abre el picker
        return campo
    }()

    private let etiquetaInfoProducto: UILabel = {
        let etiqueta = UILabel()
        etiqueta.text = "Precio: — | Stock: —"
        etiqueta.font = .systemFont(ofSize: 14)
        etiqueta.textColor = .secondaryLabel
        return etiqueta
    }()

    private let campoCliente: UITextField = {
        let campo = UITextField()
        campo.placeholder = "Selecciona un cliente"
        campo.borderStyle = .roundedRect
        campo.tintColor = .clear
        return campo
    }()

    // Muestra la categoría del cliente y si le corresponde el descuento VIP
    private let etiquetaCategoria: UILabel = {
        let etiqueta = UILabel()
        etiqueta.text = "Categoría: —"
        etiqueta.font = .systemFont(ofSize: 14)
        etiqueta.textColor = .secondaryLabel
        return etiqueta
    }()

    private let campoCantidad: UITextField = {
        let campo = UITextField()
        campo.placeholder = "Cantidad"
        campo.borderStyle = .roundedRect
        campo.keyboardType = .numberPad
        return campo
    }()

    private let etiquetaResumen: UILabel = {
        let etiqueta = UILabel()
        etiqueta.numberOfLines = 0
        etiqueta.font = .monospacedSystemFont(ofSize: 16, weight: .regular)
        etiqueta.text = "Subtotal:  S/ 0.00\nDescuento: S/ 0.00\nIGV (18%): S/ 0.00\nTOTAL:     S/ 0.00"
        return etiqueta
    }()

    private let botonRegistrar: UIButton = {
        var configuracion = UIButton.Configuration.filled()
        configuracion.title = "Registrar Venta"
        configuracion.cornerStyle = .medium
        return UIButton(configuration: configuracion)
    }()

    private let pickerProducto = UIPickerView()
    private let pickerCliente = UIPickerView()

    // MARK: - Ciclo de vida

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registrar Venta"
        view.backgroundColor = .systemBackground

        configurarPickers()
        configurarInterfaz()

        campoCantidad.addTarget(self, action: #selector(recalcular), for: .editingChanged)
        botonRegistrar.addTarget(self, action: #selector(registrarVenta), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // El vendedor es SIEMPRE el usuario de la sesión
        etiquetaVendedor.text = "Vendedor: \(Sesion.compartida.usuarioActual?.nombre ?? "—")"

        // Recargamos productos/clientes por si cambiaron en otras pestañas
        cargarDatos()
        pickerProducto.reloadAllComponents()
        pickerCliente.reloadAllComponents()

        // Si lo seleccionado ya no existe (fue eliminado), se limpia
        if let producto = productoSeleccionado, !productos.contains(producto) {
            productoSeleccionado = nil
            campoProducto.text = ""
        }
        if let cliente = clienteSeleccionado, !clientes.contains(cliente) {
            clienteSeleccionado = nil
            campoCliente.text = ""
        }
        actualizarInfoProducto()
        actualizarCategoriaCliente()
        recalcular()
    }

    private func cargarDatos() {
        let solicitudProductos: NSFetchRequest<Producto> = Producto.fetchRequest()
        solicitudProductos.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        let solicitudClientes: NSFetchRequest<Cliente> = Cliente.fetchRequest()
        solicitudClientes.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]

        let contexto = CoreDataManager.shared.context
        productos = (try? contexto.fetch(solicitudProductos)) ?? []
        clientes = (try? contexto.fetch(solicitudClientes)) ?? []
    }

    // MARK: - Pickers como "teclado" de los campos

    private func configurarPickers() {
        pickerProducto.tag = 1 // los tags distinguen qué picker llama al delegado
        pickerCliente.tag = 2
        [pickerProducto, pickerCliente].forEach {
            $0.dataSource = self
            $0.delegate = self
        }
        campoProducto.inputView = pickerProducto
        campoCliente.inputView = pickerCliente

        // Barra con "Listo" para cerrar el picker/teclado
        let barra = UIToolbar()
        barra.sizeToFit()
        barra.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(cerrarTeclado))
        ]
        [campoProducto, campoCliente, campoCantidad].forEach { $0.inputAccessoryView = barra }
    }

    @objc private func cerrarTeclado() {
        view.endEditing(true)
    }

    // MARK: - Auto Layout por código

    private func configurarInterfaz() {
        let pila = UIStackView(arrangedSubviews: [
            etiquetaVendedor, campoProducto, etiquetaInfoProducto,
            campoCliente, etiquetaCategoria, campoCantidad,
            etiquetaResumen, botonRegistrar
        ])
        pila.axis = .vertical
        pila.spacing = 14
        pila.setCustomSpacing(4, after: campoProducto)
        pila.setCustomSpacing(4, after: campoCliente)
        pila.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pila)

        NSLayoutConstraint.activate([
            pila.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pila.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            pila.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            campoProducto.heightAnchor.constraint(equalToConstant: 44),
            campoCliente.heightAnchor.constraint(equalToConstant: 44),
            campoCantidad.heightAnchor.constraint(equalToConstant: 44),
            botonRegistrar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - UIPickerViewDataSource / Delegate

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 1 ? productos.count : clientes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            let producto = productos[row]
            return "\(producto.nombre ?? "") (stock: \(producto.stock))"
        } else {
            let cliente = clientes[row]
            return "\(cliente.nombre ?? "") — \(cliente.documento ?? "")"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            productoSeleccionado = productos[row]
            campoProducto.text = productoSeleccionado?.nombre
            actualizarInfoProducto()
        } else {
            clienteSeleccionado = clientes[row]
            campoCliente.text = clienteSeleccionado?.nombre
            actualizarCategoriaCliente()
        }
        recalcular()
    }

    private func actualizarInfoProducto() {
        if let producto = productoSeleccionado {
            etiquetaInfoProducto.text = String(
                format: "Precio: S/ %.2f | Stock: %d", producto.precio, producto.stock)
        } else {
            etiquetaInfoProducto.text = "Precio: — | Stock: —"
        }
    }

    // MARK: - Categoría del cliente (regla de negocio)

    /// Suma el historial de compras del cliente SIN contar ventas anuladas
    private func totalHistorico(de cliente: Cliente) -> Double {
        let ventasCliente = (cliente.ventas as? Set<Venta>) ?? []
        return ventasCliente.filter { !$0.anulada }.reduce(0) { $0 + $1.total }
    }

    /// VIP ≥ 5000 | Frecuente ≥ 1000 | Regular < 1000
    private func categoria(de cliente: Cliente) -> String {
        let total = totalHistorico(de: cliente)
        if total >= umbralVIP { return "VIP" }
        if total >= umbralFrecuente { return "Frecuente" }
        return "Regular"
    }

    private func actualizarCategoriaCliente() {
        guard let cliente = clienteSeleccionado else {
            etiquetaCategoria.text = "Categoría: —"
            etiquetaCategoria.textColor = .secondaryLabel
            return
        }
        let nombreCategoria = categoria(de: cliente)
        let historial = totalHistorico(de: cliente)
        if nombreCategoria == "VIP" {
            // Solo el VIP recibe el descuento automático del 10%
            etiquetaCategoria.text = String(
                format: "Categoría: VIP ⭐️ (historial S/ %.2f) — 10%% de descuento", historial)
            etiquetaCategoria.textColor = .systemGreen
        } else {
            etiquetaCategoria.text = String(
                format: "Categoría: %@ (historial S/ %.2f) — sin descuento", nombreCategoria, historial)
            etiquetaCategoria.textColor = .secondaryLabel
        }
    }

    // MARK: - Cálculo de la venta

    /// Fórmula:
    ///   subtotal  = precio unitario × cantidad
    ///   descuento = 10% del subtotal SOLO si el cliente es VIP
    ///   IGV       = (subtotal − descuento) × 18%
    ///   total     = (subtotal − descuento) + IGV
    private func calcularMontos() -> (subtotal: Double, descuento: Double, igv: Double, total: Double) {
        let precio = productoSeleccionado?.precio ?? 0
        let cantidad = Double(Int64(campoCantidad.text ?? "") ?? 0)
        let subtotal = precio * cantidad

        let esVIP = clienteSeleccionado.map { categoria(de: $0) == "VIP" } ?? false
        let descuento = esVIP ? subtotal * descuentoVIP : 0

        let base = subtotal - descuento
        let igv = base * tasaIGV
        let total = base + igv
        return (subtotal, descuento, igv, total)
    }

    @objc private func recalcular() {
        let montos = calcularMontos()
        etiquetaResumen.text = String(
            format: "Subtotal:  S/ %.2f\nDescuento: S/ %.2f\nIGV (18%%): S/ %.2f\nTOTAL:     S/ %.2f",
            montos.subtotal, montos.descuento, montos.igv, montos.total)
    }

    // MARK: - Guardar la venta

    @objc private func registrarVenta() {
        view.endEditing(true)

        // El vendedor sale de la sesión activa
        guard let vendedor = Sesion.compartida.usuarioActual else {
            mostrarAlerta(mensaje: "No hay sesión activa")
            return
        }
        guard let producto = productoSeleccionado else {
            mostrarAlerta(mensaje: "Selecciona un producto")
            return
        }
        guard let cliente = clienteSeleccionado else {
            mostrarAlerta(mensaje: "Selecciona un cliente")
            return
        }
        guard let cantidad = Int64(campoCantidad.text ?? ""), cantidad > 0 else {
            mostrarAlerta(mensaje: "Ingresa una cantidad válida (mayor a 0)")
            return
        }
        // REGLA: si la cantidad supera el stock, alerta y NO se registra
        guard cantidad <= producto.stock else {
            mostrarAlerta(mensaje: "Stock insuficiente: solo hay \(producto.stock) unidades de \(producto.nombre ?? "")")
            return
        }

        let montos = calcularMontos()

        // Creación de la Venta con sus 3 relaciones To One
        let venta = Venta(context: CoreDataManager.shared.context)
        venta.fecha = Date()
        venta.cantidad = cantidad
        venta.precioUnitario = producto.precio // se "congela" el precio del momento
        venta.descuento = montos.descuento     // monto descontado (0 si no es VIP)
        venta.igv = montos.igv
        venta.total = montos.total
        venta.anulada = false
        venta.vendedor = vendedor
        venta.producto = producto
        venta.cliente = cliente

        // Se descuenta el stock vendido
        producto.stock -= cantidad

        if CoreDataManager.shared.guardar() {
            let alerta = UIAlertController(
                title: "✅ Venta registrada",
                message: String(format: "Total: S/ %.2f\nStock restante de %@: %d",
                                montos.total, producto.nombre ?? "", producto.stock),
                preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.limpiarFormulario() // la pantalla queda lista para otra venta
            })
            present(alerta, animated: true)
        } else {
            mostrarAlerta(mensaje: "No se pudo guardar la venta")
        }
    }

    // Restablece el formulario después de registrar
    private func limpiarFormulario() {
        productoSeleccionado = nil
        clienteSeleccionado = nil
        campoProducto.text = ""
        campoCliente.text = ""
        campoCantidad.text = ""
        actualizarInfoProducto()
        actualizarCategoriaCliente()
        recalcular()
    }

    private func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Atención", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
}
