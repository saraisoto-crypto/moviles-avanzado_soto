# 🛒 Ventas · Grupo A · UIKit + Core Data

Trabajo de la Semana 11 del curso **Programación en Móviles Avanzado** (Tecsup).

| | |
|---|---|
| **Alumna** | Sarai Sthefanie Soto López |
| **Docente** | Juan León |
| **Ciclo** | 5 C24 · 2026-II |
| **Tecnología** | Swift · UIKit · Core Data |

## 📱 Descripción
Aplicación para una tienda que registra productos, clientes y ventas. Tiene inicio de sesión, registro y dos roles (**Vendedor** y **Supervisor**). Las pestañas del `UITabBarController` cambian según el rol, y cada venta guarda quién la registró.

## 👥 Roles y permisos
| | Vendedor | Supervisor |
|---|---|---|
| **Pestañas** | Productos, Clientes, Venta, Mis ventas, Cuenta | Resumen, Ventas, Productos, Clientes, Cuenta |
| **Productos** | Consultar y buscar | Crear, editar y borrar |
| **Clientes** | Crear, editar y consultar | Crear, editar, consultar y borrar |
| **Ventas** | Registrar y ver solo las suyas | Ver todas, filtrar por vendedor y anular con motivo |
| **Resumen** | No lo ve | Indicadores, gráfico de 7 días y ranking |

## 🗂️ Modelo de datos (Core Data)
| Entidad | Atributos | Relaciones |
|---|---|---|
| **Usuario** | nombre, usuario, clave, rol | ventas → Venta (To Many, **Deny**) |
| **Producto** | nombre, categoria, precio, stock | ventas → Venta (To Many, **Deny**) |
| **Cliente** | nombre, documento | ventas → Venta (To Many, **Deny**) |
| **Venta** | fecha, cantidad, precioUnitario, descuento, igv, total, anulada, motivoAnulacion | vendedor → Usuario · producto → Producto · cliente → Cliente |

La regla **Deny** impide borrar un usuario, producto o cliente que tenga ventas.

## 📐 Reglas de negocio
- **Categoría del cliente** (calculada con ventas no anuladas): Regular < S/ 1,000 · Frecuente ≥ S/ 1,000 · VIP ≥ S/ 5,000.
- **Descuento:** 10 % del subtotal solo para clientes VIP.
- **IGV:** 18 % sobre (subtotal − descuento).
- **Total** = subtotal − descuento + IGV.
- **Stock:** baja al registrar la venta; si la cantidad supera el stock, se muestra una alerta y no se registra.
- **Anular** (solo supervisor): exige motivo, marca la venta como anulada y devuelve el stock.

**Ejemplo:** 2 Monitores a S/ 650.00 (cliente Regular) → subtotal 1,300.00 · IGV 234.00 · **total 1,534.00** · el stock baja de 15 a 13.

## 🖥️ Pantallas
| Código | Pantalla | Archivo |
|---|---|---|
| A1 | Login | `LoginViewController.swift` |
| A2 | Registro | `RegistroViewController.swift` |
| A3 | Productos | `ProductosViewController.swift` |
| A4 | Clientes | `ClientesViewController.swift` |
| A5 | Registrar venta | `RegistrarVentaViewController.swift` |
| A6 | Mis ventas | `MisVentasViewController.swift` |
| A7 / A8 | Ventas del equipo y anulación | `VentasViewController.swift` |
| A9 | Resumen del supervisor | `ResumenViewController.swift` |
| — | Cuenta | `CuentaViewController.swift` |

**Otros archivos:**
- `Sesion.swift`: guarda el usuario conectado (objeto compartido con `static let`).
- `CoreDataManager.swift`: acceso al contexto y guardado.
- `PrincipalTabBarController.swift`: arma las pestañas según el rol.

## ▶️ Cómo ejecutar
1. Abrir `apple_lab11_03_UIKit_CoreData_Ventas.xcodeproj` en Xcode.
2. Elegir un simulador de iPhone y pulsar **Run (⌘R)**.
3. Crear una cuenta como **Supervisor** para registrar productos, y otra como **Vendedor** para registrar ventas.
