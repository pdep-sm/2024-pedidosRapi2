import clientes.*

class Pedido {
  const items = #{}
  const local

  /*
  Punto 1 - Calcular sólo el precio bruto de un pedido, es decir, sin tener en cuenta el cliente.
  El pedido tiene un precio bruto que no tiene en cuenta el envío al domicilio del cliente. 
  Dicho precio se calcula como la sumatoria del precio de cada producto multiplicado 
  por la cantidad solicitada.
  */
  method precioBruto() = items.sum{item => item.precio()}

  /* 
  Punto 2.a - Determinar el costo real de envío de un pedido para un cliente.
  El costo real de envío depende de la cantidad de cuadras de distancia entre el local 
  y el cliente. Y se calcula como $15 por cuadra, pero como tope $300.
  */
  method costoRealEnvio(cliente) = 
    (calculadorCuadras.calcularCuadras(cliente, local) * 15).min(300)

  /* 
  Punto 2.b - Dado un pedido, saber cual es el valor de envío que debe abonar un cliente determinado.
  */ 
  method valorDeEnvio(cliente) = self.costoRealEnvio(cliente) * (1 - cliente.factorDescuento())

  /*
  Punto 3.a - Agregar a un pedido una cantidad de un producto.
  El pedido puede ya incluir el producto anteriormente, en cuyo caso sólo debe incrementarse la cantidad del ítem correspondiente.
  */
  method agregarProducto(cantidad, producto) {
    const item = 
      items.findOrDefault({i => i.producto() == producto }, new Item(producto = producto))
    item.agregarCantidad(cantidad)
    items.add(item) // Definimos items como un Set: Si ya existía el item, no pasa nada.
  }
}

class Item {
  const producto
  var cantidad = 0

  method precio() = producto.precio() * cantidad

  method agregarCantidad(cantidadAgregada) {
    cantidad += cantidadAgregada
  }
}

class Producto {
  const property precio
}

/*
Existe un Calculador de Cuadras, que dado un cliente y un local, retorna la cantidad de cuadras de distancia 
(sólo se debe representar al calculador, no hace falta implementarlo*/
object calculadorCuadras {
  method calcularCuadras(cliente, local) = 10 // valor arbitrario, lo importante es que devuelve un nro. de cuadras
}
