package bitacora

import audita.Auditable

class Empresa implements Auditable{

    Date fechaInicio
    Date fechaFin
    String nombre
    String direccion
    String sigla
    String telefono
    String mail
    String observaciones
    String ruc

    static auditable = [ignore: []]

    static mapping = {
        table 'empr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'empr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'empr__id'
            fechaInicio column: 'emprfcin'
            fechaFin column: 'emprfcfn'
            nombre column: 'emprnmbr'
            direccion column: 'emprdire'
            sigla column: 'emprsgla'
            telefono column: 'emprtelf'
            mail column: 'emprmail'
            observaciones column: 'emprobsr'
            ruc column: 'empr_ruc'
        }
    }

    static constraints = {
        fechaInicio(blank:true, nullable: true)
        fechaFin(blank:true, nullable: true)
        nombre(size: 1..255, blank: false, nullable: false)
        direccion(size: 1..255, blank: true, nullable: true)
        sigla(size: 1..7, blank: true, nullable: true)
        telefono(size: 1..63, blank: true, nullable: true)
        mail(size: 1..63, blank: true, nullable: true)
        observaciones(size: 1..255, blank: true, nullable: true)
        ruc(size: 1..13, blank: true, nullable: true)
    }

    String toString() {
        return this.nombre
    }
}
