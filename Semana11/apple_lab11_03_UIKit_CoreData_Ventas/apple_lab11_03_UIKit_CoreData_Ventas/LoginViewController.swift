//
//  LoginViewController.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Pantalla A1: inicio de sesión (rediseñada).
//  - Encabezado con DEGRADADO y logo de la app
//  - "Tarjeta" flotante con sombra que contiene el formulario
//  - Campos con ícono y botón de ojo 👁 para ver la clave
//  - Mensaje GENÉRICO si falla + botón "Crear cuenta" (A2)
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    // MARK: - Componentes de la interfaz (creados por código)

    // Fondo degradado del encabezado (color principal → azul)
    private let encabezado = VistaGradiente(colores: [Estilos.colorPrimario, .systemBlue])

    private let etiquetaTitulo: UILabel = {
        let etiqueta = UILabel()
        etiqueta.text = "Sistema de Ventas"
        etiqueta.font = .systemFont(ofSize: 30, weight: .bold)
        etiqueta.textColor = .white
        etiqueta.textAlignment = .center
        return etiqueta
    }()

    private let etiquetaSubtitulo: UILabel = {
        let etiqueta = UILabel()
        etiqueta.text = "UIKit + Core Data — Grupo A"
        etiqueta.font = .systemFont(ofSize: 15)
        etiqueta.textColor = UIColor.white.withAlphaComponent(0.85)
        etiqueta.textAlignment = .center
        return etiqueta
    }()

    // Tarjeta blanca con sombra que "flota" sobre el degradado
    private let tarjeta: UIView = {
        let vista = UIView()
        vista.backgroundColor = .systemBackground
        vista.layer.cornerRadius = 24
        // Sombra suave para dar profundidad
        vista.layer.shadowColor = UIColor.black.cgColor
        vista.layer.shadowOpacity = 0.12
        vista.layer.shadowRadius = 16
        vista.layer.shadowOffset = CGSize(width: 0, height: 6)
        return vista
    }()

    private let campoUsuario: UITextField = {
        let campo = UITextField()
        campo.placeholder = "Usuario"
        campo.autocapitalizationType = .none // los usuarios se escriben en minúscula
        campo.autocorrectionType = .no
        return campo
    }()

    private let campoClave: UITextField = {
        let campo = UITextField()
        campo.placeholder = "Clave"
        campo.isSecureTextEntry = true // oculta la clave con puntos
        return campo
    }()

    private let botonIngresar: UIButton = {
        var configuracion = UIButton.Configuration.filled()
        configuracion.title = "Ingresar"
        configuracion.cornerStyle = .large
        return UIButton(configuration: configuracion)
    }()

    private let botonCrearCuenta: UIButton = {
        var configuracion = UIButton.Configuration.plain()
        configuracion.title = "¿No tienes cuenta? Crear cuenta"
        return UIButton(configuration: configuracion)
    }()

    // MARK: - Ciclo de vida

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // Precargamos datos de prueba la primera vez (usuarios, productos, clientes)
        CoreDataManager.shared.precargarDatosSiEsNecesario()

        configurarInterfaz()

        // Estilo de los campos: fondo redondeado + ícono + ojo en la clave
        campoUsuario.aplicarEstiloTarjeta(icono: "person")
        campoClave.aplicarEstiloTarjeta(icono: "lock")
        campoClave.agregarBotonVerClave()

        botonIngresar.addTarget(self, action: #selector(ingresar), for: .touchUpInside)
        botonCrearCuenta.addTarget(self, action: #selector(abrirRegistro), for: .touchUpInside)

        // Tocar fuera de los campos cierra el teclado
        let toque = UITapGestureRecognizer(target: self, action: #selector(cerrarTeclado))
        toque.cancelsTouchesInView = false // no bloquea los botones
        view.addGestureRecognizer(toque)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // El login se ve a pantalla completa, sin barra de navegación
        navigationController?.setNavigationBarHidden(true, animated: animated)
        campoClave.text = "" // por seguridad, la clave no se conserva
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Al salir (por ejemplo al Registro) la barra vuelve a mostrarse
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Auto Layout por código

    private func configurarInterfaz() {
        // ---- Encabezado degradado con esquinas inferiores redondeadas ----
        encabezado.layer.cornerRadius = 32
        encabezado.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        encabezado.clipsToBounds = true
        encabezado.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(encabezado)

        // Logo: ícono de carrito dentro de un círculo translúcido
        let circulo = UIView()
        circulo.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        circulo.layer.cornerRadius = 40
        let iconoCarrito = UIImageView(image: UIImage(systemName: "cart.fill"))
        iconoCarrito.tintColor = .white
        iconoCarrito.contentMode = .scaleAspectFit
        iconoCarrito.translatesAutoresizingMaskIntoConstraints = false
        circulo.addSubview(iconoCarrito)

        let pilaEncabezado = UIStackView(arrangedSubviews: [circulo, etiquetaTitulo, etiquetaSubtitulo])
        pilaEncabezado.axis = .vertical
        pilaEncabezado.alignment = .center
        pilaEncabezado.spacing = 12
        pilaEncabezado.translatesAutoresizingMaskIntoConstraints = false
        encabezado.addSubview(pilaEncabezado)

        // ---- Tarjeta del formulario ----
        tarjeta.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tarjeta)

        let pilaFormulario = UIStackView(arrangedSubviews: [
            campoUsuario, campoClave, botonIngresar, botonCrearCuenta
        ])
        pilaFormulario.axis = .vertical
        pilaFormulario.spacing = 14
        pilaFormulario.setCustomSpacing(22, after: campoClave)
        pilaFormulario.setCustomSpacing(6, after: botonIngresar)
        pilaFormulario.translatesAutoresizingMaskIntoConstraints = false
        tarjeta.addSubview(pilaFormulario)

        NSLayoutConstraint.activate([
            // Degradado pegado al borde superior (pasa por detrás del notch)
            encabezado.topAnchor.constraint(equalTo: view.topAnchor),
            encabezado.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            encabezado.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            encabezado.heightAnchor.constraint(equalToConstant: 310),

            // Logo circular de 80x80 con el carrito centrado
            circulo.widthAnchor.constraint(equalToConstant: 80),
            circulo.heightAnchor.constraint(equalToConstant: 80),
            iconoCarrito.centerXAnchor.constraint(equalTo: circulo.centerXAnchor),
            iconoCarrito.centerYAnchor.constraint(equalTo: circulo.centerYAnchor),
            iconoCarrito.widthAnchor.constraint(equalToConstant: 38),
            iconoCarrito.heightAnchor.constraint(equalToConstant: 38),

            pilaEncabezado.centerXAnchor.constraint(equalTo: encabezado.centerXAnchor),
            pilaEncabezado.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),

            // La tarjeta se superpone al degradado (efecto "flotante")
            tarjeta.topAnchor.constraint(equalTo: encabezado.bottomAnchor, constant: -44),
            tarjeta.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tarjeta.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Formulario con margen interno de 24 puntos
            pilaFormulario.topAnchor.constraint(equalTo: tarjeta.topAnchor, constant: 24),
            pilaFormulario.bottomAnchor.constraint(equalTo: tarjeta.bottomAnchor, constant: -24),
            pilaFormulario.leadingAnchor.constraint(equalTo: tarjeta.leadingAnchor, constant: 20),
            pilaFormulario.trailingAnchor.constraint(equalTo: tarjeta.trailingAnchor, constant: -20),

            campoUsuario.heightAnchor.constraint(equalToConstant: 48),
            campoClave.heightAnchor.constraint(equalToConstant: 48),
            botonIngresar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func cerrarTeclado() {
        view.endEditing(true)
    }

    // MARK: - Acciones

    // Navega a la pantalla de registro (A2)
    @objc private func abrirRegistro() {
        navigationController?.pushViewController(RegistroViewController(), animated: true)
    }

    @objc private func ingresar() {
        view.endEditing(true) // cerramos el teclado

        guard let usuario = campoUsuario.text, !usuario.isEmpty,
              let clave = campoClave.text, !clave.isEmpty else {
            mostrarAlerta(mensaje: "Ingresa tu usuario y clave")
            return
        }

        // Consulta con NSPredicate: usuario (sin distinguir mayúsculas) y clave exacta
        let solicitud: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        solicitud.predicate = NSPredicate(format: "usuario ==[c] %@ AND clave == %@", usuario, clave)

        do {
            let resultados = try CoreDataManager.shared.context.fetch(solicitud)
            if let usuarioEncontrado = resultados.first {
                // Guardamos la sesión y entramos a la app (TabBar según rol)
                Sesion.compartida.usuarioActual = usuarioEncontrado
                entrarALaApp()
            } else {
                // Mensaje GENÉRICO a propósito: no revelamos si el error
                // fue el usuario o la clave (buena práctica de seguridad)
                mostrarAlerta(mensaje: "Usuario o clave incorrectos")
            }
        } catch {
            mostrarAlerta(mensaje: "Error al consultar la base de datos")
        }
    }

    // Reemplaza la raíz de la ventana por el TabBar principal
    private func entrarALaApp() {
        guard let ventana = view.window else { return }
        ventana.rootViewController = PrincipalTabBarController()
        // Transición suave al cambiar de pantalla raíz
        UIView.transition(with: ventana, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }

    private func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Atención", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
}
