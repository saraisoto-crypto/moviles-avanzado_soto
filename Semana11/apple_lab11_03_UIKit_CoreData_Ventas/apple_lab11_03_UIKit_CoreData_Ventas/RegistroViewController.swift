//
//  RegistroViewController.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Pantalla A2: registro de una cuenta nueva (estilo a juego con el login).
//  Validaciones:
//  - Nombre completo obligatorio
//  - Usuario ÚNICO sin distinguir mayúsculas (NSPredicate "usuario ==[c] %@")
//  - Clave de mínimo 6 caracteres + confirmación (ambas con botón 👁)
//  - Rol elegido con UISegmentedControl (Vendedor / Supervisor)
//  Al tocar "Registrarme" se crea el Usuario y se entra DIRECTO a la app.
//

import UIKit
import CoreData

class RegistroViewController: UIViewController {

    // MARK: - Componentes de la interfaz

    private let etiquetaTitulo: UILabel = {
        let etiqueta = UILabel()
        etiqueta.text = "Crea tu cuenta"
        etiqueta.font = .systemFont(ofSize: 28, weight: .bold)
        return etiqueta
    }()

    private let etiquetaSubtitulo: UILabel = {
        let etiqueta = UILabel()
        etiqueta.text = "Completa tus datos para empezar a vender"
        etiqueta.font = .systemFont(ofSize: 15)
        etiqueta.textColor = .secondaryLabel
        return etiqueta
    }()

    private let campoNombre: UITextField = {
        let campo = UITextField()
        campo.placeholder = "Nombre completo"
        return campo
    }()

    private let campoUsuario: UITextField = {
        let campo = UITextField()
        campo.placeholder = "Usuario (login)"
        campo.autocapitalizationType = .none
        campo.autocorrectionType = .no
        return campo
    }()

    private let campoClave: UITextField = {
        let campo = UITextField()
        campo.placeholder = "Clave (mínimo 6 caracteres)"
        campo.isSecureTextEntry = true
        return campo
    }()

    private let campoConfirmarClave: UITextField = {
        let campo = UITextField()
        campo.placeholder = "Confirmar clave"
        campo.isSecureTextEntry = true
        return campo
    }()

    // Selector del rol: solo hay dos roles válidos en el sistema
    private let segmentoRol: UISegmentedControl = {
        let segmento = UISegmentedControl(items: ["🛒 Vendedor", "⭐️ Supervisor"])
        segmento.selectedSegmentIndex = 0 // por defecto: Vendedor
        return segmento
    }()

    private let botonRegistrarme: UIButton = {
        var configuracion = UIButton.Configuration.filled()
        configuracion.title = "Registrarme"
        configuracion.cornerStyle = .large
        return UIButton(configuration: configuracion)
    }()

    // MARK: - Ciclo de vida

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crear cuenta"
        view.backgroundColor = .systemBackground
        configurarInterfaz()

        // Estilo de campos: fondo redondeado + ícono (igual que el login)
        campoNombre.aplicarEstiloTarjeta(icono: "person.text.rectangle")
        campoUsuario.aplicarEstiloTarjeta(icono: "at")
        campoClave.aplicarEstiloTarjeta(icono: "lock")
        campoConfirmarClave.aplicarEstiloTarjeta(icono: "lock.rotation")

        // Botón de ojo 👁 en ambos campos de clave
        campoClave.agregarBotonVerClave()
        campoConfirmarClave.agregarBotonVerClave()

        botonRegistrarme.addTarget(self, action: #selector(registrarme), for: .touchUpInside)

        // Tocar fuera de los campos cierra el teclado
        let toque = UITapGestureRecognizer(target: self, action: #selector(cerrarTeclado))
        toque.cancelsTouchesInView = false
        view.addGestureRecognizer(toque)
    }

    @objc private func cerrarTeclado() {
        view.endEditing(true)
    }

    // MARK: - Auto Layout por código

    private func configurarInterfaz() {
        let etiquetaRol = UILabel()
        etiquetaRol.text = "¿Cuál será tu rol?"
        etiquetaRol.font = .systemFont(ofSize: 16, weight: .semibold)

        let pila = UIStackView(arrangedSubviews: [
            etiquetaTitulo, etiquetaSubtitulo,
            campoNombre, campoUsuario, campoClave, campoConfirmarClave,
            etiquetaRol, segmentoRol, botonRegistrarme
        ])
        pila.axis = .vertical
        pila.spacing = 14
        pila.setCustomSpacing(4, after: etiquetaTitulo)
        pila.setCustomSpacing(24, after: etiquetaSubtitulo)
        pila.setCustomSpacing(8, after: etiquetaRol)
        pila.setCustomSpacing(30, after: segmentoRol)
        pila.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pila)

        NSLayoutConstraint.activate([
            pila.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pila.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            pila.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            campoNombre.heightAnchor.constraint(equalToConstant: 48),
            campoUsuario.heightAnchor.constraint(equalToConstant: 48),
            campoClave.heightAnchor.constraint(equalToConstant: 48),
            campoConfirmarClave.heightAnchor.constraint(equalToConstant: 48),
            segmentoRol.heightAnchor.constraint(equalToConstant: 40),
            botonRegistrarme.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Registro

    @objc private func registrarme() {
        view.endEditing(true)

        // ---- Validaciones de los campos ----
        guard let nombre = campoNombre.text?.trimmingCharacters(in: .whitespaces), !nombre.isEmpty else {
            mostrarAlerta(mensaje: "Ingresa tu nombre completo")
            return
        }
        guard let usuario = campoUsuario.text?.trimmingCharacters(in: .whitespaces), !usuario.isEmpty else {
            mostrarAlerta(mensaje: "Ingresa un nombre de usuario")
            return
        }
        guard let clave = campoClave.text, clave.count >= 6 else {
            mostrarAlerta(mensaje: "La clave debe tener mínimo 6 caracteres")
            return
        }
        guard campoConfirmarClave.text == clave else {
            mostrarAlerta(mensaje: "Las claves no coinciden")
            return
        }

        // ---- Usuario ÚNICO sin distinguir mayúsculas ----
        // El modificador [c] del predicate hace la comparación case-insensitive:
        // "jperez", "JPerez" y "JPEREZ" cuentan como el mismo usuario.
        let solicitud: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        solicitud.predicate = NSPredicate(format: "usuario ==[c] %@", usuario)
        let existentes = (try? CoreDataManager.shared.context.count(for: solicitud)) ?? 0
        guard existentes == 0 else {
            mostrarAlerta(mensaje: "El usuario \"\(usuario)\" ya existe. Elige otro.")
            return
        }

        // ---- Creación del usuario en Core Data ----
        let rol = segmentoRol.selectedSegmentIndex == 0 ? "Vendedor" : "Supervisor"
        let nuevoUsuario = Usuario(context: CoreDataManager.shared.context)
        nuevoUsuario.nombre = nombre
        nuevoUsuario.usuario = usuario
        nuevoUsuario.clave = clave
        nuevoUsuario.rol = rol

        guard CoreDataManager.shared.guardar() else {
            mostrarAlerta(mensaje: "No se pudo crear la cuenta")
            return
        }

        // "Registrarme entra directo a la app": guardamos la sesión
        // y reemplazamos la raíz por el TabBar (sin volver al login)
        Sesion.compartida.usuarioActual = nuevoUsuario
        guard let ventana = view.window else { return }
        ventana.rootViewController = PrincipalTabBarController()
        UIView.transition(with: ventana, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }

    private func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Atención", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
}
