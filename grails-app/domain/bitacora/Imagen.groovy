package bitacora

class Imagen {

    Base base
    String ruta
    String descripcion

    static mapping = {
        table 'kimg'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id            column: 'kimg__id'
            base          column: 'base__id'
            ruta          column: 'kimgruta'
            descripcion   column: 'kimgdscr'
        }
    }

    static constraints = {
        ruta(size: 3..255, blank: false, nullable: false)
        descripcion(size: 5..255, blank: true, nullable: true)
    }

    String toString() {
        "${this.id}: ${this.descripcion}"
    }

}
