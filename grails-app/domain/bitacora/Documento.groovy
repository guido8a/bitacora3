package bitacora

import seguridad.Departamento

/* Es toda documentación importante que debe ser archivada dentro de cada departamento.*/
/**
 * Clase para conectar con la tabla 'dcmt' de la base de datos<br/>
 * Es toda documentación importante que debe ser archivada en el proyecto.
 * Esta comprende el archivo de proyecto o el archivo de casos de proyecto.
 * Se usará preferentemente formato pdf, pero pueden incluirse otros formatos aunque no puedan ser visualizados desde el sistema.
 */

class Documento {
    String descripcion
    String clave
    String resumen
    String ruta
    Departamento departamento

    static auditable = [ignore: []]

    static mapping = {
        table 'dcmt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dcmt__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dcmt__id'
            descripcion column: 'dcmtdscr'
            clave column: 'dcmtclve'
            resumen column: 'dcmtrsmn'
            ruta  column: 'dcmtruta'
            departamento column: 'dpto__id'
        }
    }

    static constraints = {
        descripcion(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Descripción del documento'])
        clave(size: 1..127, blank: true, nullable: true, attributes: [mensaje: 'Palabras clave'])
        resumen(size: 1..1024, blank: true, nullable: true, attributes: [mensaje: 'Resumen'])
        ruta(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Ruta del documento'])
        departamento(blank: true, nullable: true)
    }

    String toString() {
        return this.descripcion
    }
}