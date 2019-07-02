package bitacora

class Prioridad {
  String codigo
  String descripcion

  static mapping = {
    table 'prdd'
    cache usage: 'read-write', include: 'non-lazy'
    id generator: 'identity'
    version false
    columns {
      id column: 'prdd__id'
      codigo column: 'prddcdgo'
      descripcion column: 'prdddscr'
    }
  }

  static constraints = {
    descripcion(inList: ["Alta", "Baja", "Media"])
  }

  String toString() {
    "${this.descripcion}"
  }
}
