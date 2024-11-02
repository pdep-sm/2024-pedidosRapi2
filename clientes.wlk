class Cliente {
  var tipoCliente

  method factorDescuento() = tipoCliente.factorDescuento()
}


object clienteComun {
  method factorDescuento() = 0
}

object clienteSilver{
  method factorDescuento() = 0.5
}

class ClienteGold {
  var cantCompras = 0
  
  method factorDescuento() = if (self.tieneEnvioGratis()) 1 else 0.9

  method tieneEnvioGratis() = cantCompras % 5 == 0
}
