package bitacora

import audita.Auditable

class Proyecto implements Auditable{

    Empresa empresa
    String descripcion
    String responsable
    String telefono
    String mail

    static auditable = [ignore: []]

    static mapping = {
        table 'proy'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'proy__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'proy__id'
            empresa column: 'empr__id'
            descripcion column: 'proydscr'
            responsable column: 'proyrspn'
            telefono column: 'proytelf'
            mail column: 'proymail'
        }
    }

    static constraints = {
        empresa(blank:false, nullable: false)
        descripcion(size: 1..63, blank:false, nullable: false)
        responsable(size: 1..63, blank:false, nullable: false)
        telefono(size: 1..63, blank:true, nullable: true)
        mail(size: 1..63, blank:true, nullable: true)
    }
}
