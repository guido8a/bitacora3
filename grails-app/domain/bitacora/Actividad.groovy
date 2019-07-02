package bitacora

import seguridad.Persona

class Actividad {
    Actividad padre
    String    descripcion
    Date      fechaRegistro
    Date      fechaInicio
    Date      fechaFin
    int       avance = 0
    int       horas = 1
    Double    tiempo = 0
    Prioridad prioridad
    Persona ingresa
    Persona responsable
    String    como
    String    observaciones

    static mapping = {
        table 'actv'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false
        columns {
            id            column: 'actv__id'
            padre         column: 'actvpdre'
            descripcion   column: 'actvdscr'
            fechaRegistro column: 'actvfcha'
            fechaInicio   column: 'actvfcin'
            fechaFin      column: 'actvfcfn'
            horas         column: 'actvhora'
            tiempo        column: 'actvtmpo'
            ingresa       column: 'prsn__id'
            responsable   column: 'prsnpara'
            prioridad     column: 'prdd__id'
            como          column: 'actvcomo'
            avance        column: 'actvavnc'
            observaciones column: 'actvobsr'

        }
    }

//    String toString() {
//        "${this.responsable} : ${this.descripcion}"
//    }

    static constraints = {
        padre(blank: true, nullable: true)
        descripcion(size: 5..255, blank: false)
        fechaInicio(blank: true, nullable: true)
        fechaFin(blank: true, nullable: true)
        horas(blank: false, nullable: false)
        tiempo(blank: true, nullable: true)
        ingresa(blank: false, nullable: false)
        responsable(blank: false, nullable: false)
        prioridad(blank: false, nullable: false)
        como(blank: true, nullable: true)
        avance(blank: false, nullable: false)
        observaciones(blank: true, nullable: true)
    }
/*
    def beforeInsert = {
        descripcion = descripcion.toUpperCase()
    }
*/

}
