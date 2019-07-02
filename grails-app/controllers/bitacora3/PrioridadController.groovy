package bitacora3

import bitacora.Prioridad


class PrioridadController extends seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def getLista(params, all) {
        params = params.clone()
        if (all) {
            params.remove("offset")
            params.remove("max")
        }
        def lista
        if (params.search) {
            def c = Prioridad.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Prioridad.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def prioridadInstanceList = getLista(params, false)
        def prioridadInstanceCount = getLista(params, true).size()
        if(prioridadInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        prioridadInstanceList = getLista(params, false)
        return [prioridadInstanceList: prioridadInstanceList, prioridadInstanceCount: prioridadInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def prioridadInstance = Prioridad.get(params.id)
            if(!prioridadInstance) {
                notFound_ajax()
                return
            }
            return [prioridadInstance: prioridadInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def prioridadInstance = new Prioridad(params)
        if(params.id) {
            prioridadInstance = Prioridad.get(params.id)
            if(!prioridadInstance) {
                notFound_ajax()
                return
            }
        }
        return [prioridadInstance: prioridadInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.codigo = params.codigo.toUpperCase()
        println "params: $params"
        def prioridadInstance = new Prioridad()
        if(params.id) {
            prioridadInstance = Prioridad.get(params.id)
            if(!prioridadInstance) {
                notFound_ajax()
                return
            }
        } //update
        prioridadInstance.properties = params
        if(!prioridadInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Prioridad."
            msg += renderErrors(bean: prioridadInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Prioridad exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def prioridadInstance = Prioridad.get(params.id)
            if(prioridadInstance) {
                try {
                    prioridadInstance.delete(flush:true)
                    render "OK_Eliminación de Prioridad exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Prioridad."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Prioridad."
    } //notFound para ajax

}
