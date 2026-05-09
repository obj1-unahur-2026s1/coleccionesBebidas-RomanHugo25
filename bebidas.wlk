import ingredientes.*

object whisky {
  method rendimientoQueOtorga(dosisConsumida) = 0.9 ** dosisConsumida
}

object terere {
  method rendimientoQueOtorga(dosisConsumida) = 1.max(0.1 * dosisConsumida)
}

object cianuro {
  method rendimientoQueOtorga(dosisConsumida) = 0
}

object licuadoDeFrutas {
  const nutrientes={}
  method nuevoLicuado(unIngrediente) {
    nutrientes.clear()
    nutrientes.add(unIngrediente.nutriente())
  }
  method agregarAlLicuado(unIngrediente) {
    nutrientes.add(unIngrediente.nutriente())
  }
  method rendimientoQueOtorga(dosisConsumida) = dosisConsumida * nutrientes.sum({n=>n.nutriente().rendimiento()}) * 0.001
}

object aguaSaborizada {
  var componenteActivo = whisky
  method componenteActivo(nuevoComponente) {  componenteActivo = nuevoComponente  } 
  method rendimientoQueOtorga(dosisConsumida) = 1 + componenteActivo.rendimientoQueOtorga(dosisConsumida * 0.25)
}

object coctel {
  const compuestos=#{}
  method nuevoCoctel(unaBebida) {
    compuestos.clear()
    compuestos.add(unaBebida)
  }
  method agregarAlCoctel(unaBebida) {
    compuestos.add(unaBebida)
  }
  method rendimientoQueOtorga(dosisConsumida){
    var rendimiento = 1
    if (compuestos.isEmpty())
      rendimiento = 0
    else
      rendimiento = compuestos.map({ b => b.rendimientoQueOtorga(dosisConsumida) })
                     .fold(1, { acumulado, rend => acumulado * rend })
      //compuestos.forEach({b=> rendimiento *= b.rendimientoQueOtorga(dosisConsumida) })
    return rendimiento

    
  }
}