package bitacora3

import bitacora.Actividad


class ActividadController {

    def dbConnectionService
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
            def c = Actividad.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
//                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Actividad.list(params)
        }

        return lista.sort{ it.id}
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def actividadInstanceList = getLista(params, false)
        def actividadInstanceCount = getLista(params, true).size()
        if (actividadInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        actividadInstanceList = getLista(params, false)
        return [actividadInstanceList: actividadInstanceList, actividadInstanceCount: actividadInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def actividadInstance = Actividad.get(params.id)
            if (!actividadInstance) {
                notFound_ajax()
                return
            }
            return [actividadInstance: actividadInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def actividadInstance = new Actividad(params)
        if (params.id) {
            actividadInstance = Actividad.get(params.id)
            if (!actividadInstance) {
                notFound_ajax()
                return
            }
        }
        return [actividadInstance: actividadInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.fechaFin = new Date().parse("dd-MM-yyyy HH:mm", params.fechaFin.toString())
        def actividadInstance = new Actividad()
        if (params.id) {
            actividadInstance = Actividad.get(params.id)
            if (!actividadInstance) {
                notFound_ajax()
                return
            }
        } else {
            actividadInstance.ingresa = session.usuario
            actividadInstance.fechaRegistro = new Date()
        }
        actividadInstance.properties = params
        if (!actividadInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Actividad."
            msg += renderErrors(bean: actividadInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Actividad exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def actividadInstance = Actividad.get(params.id)
            if (actividadInstance) {
                try {
                    actividadInstance.delete(flush: true)
                    render "OK_Eliminación de Actividad exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Actividad."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    //invoca desde lista de actividades personales.

    def iniciar_ajax() {
//        println "iniciar_ajax: $params"
        if (params.id) {
            def actividadInstance = Actividad.get(params.id)
            println "actividad: $actividadInstance"
            if (!actividadInstance) {
                notFound_ajax()
                return
            } else if (actividadInstance?.fechaInicio) {
                render "NO_actividad ya está iniciada"
                return

            } else {
                println "inicia actividad ... ${actividadInstance.id}"
                try {
                    actividadInstance.fechaInicio = new Date()
                    actividadInstance.save(flush: true)
                    render "OK_Inicio de Actividad exitosa."
                    return
                } catch (e) {
                    render "NO_No se pudo iniciar la Actividad."
                }
            }
        }  else {
            notFound_ajax()
            return
        }
    }

    def finalizar_ajax() {
//        println "finalizar_ajax: $params"
        if (params.id) {
            def actividadInstance = Actividad.get(params.id)
            println "actividad: $actividadInstance"
            if (!actividadInstance) {
                notFound_ajax()
                return
            } else if (actividadInstance?.fechaFin) {
                render "NO_actividad ya está finalizada"
                return

            } else {
                println "finaliza actividad ... ${actividadInstance.id}"
                try {
                    actividadInstance.fechaFin = new Date()
                    actividadInstance.save(flush: true)
                    render "OK_Finalización de Actividad exitosa."
                    return
                } catch (e) {
                    render "NO_No se pudo finalizar la Actividad."
                }
            }
        }  else {
            notFound_ajax()
            return
        }
    }

    protected void notFound_ajax() {
        render "NO_No se encontró Actividad."
    } //notFound para ajax


    def mostrarFechaFin_ajax() {
//        println("params ff " + params)
        def dias = params.dias
        def cn = dbConnectionService.getConnection()
        def sql = "select * from tmpo_hasta('${params.fecha}', '${dias}')"
        def res = cn.firstRow(sql.toString())
//        println("sql " + sql)

//        def formateado = new Date().parse("yyyy-MM-dd", res.tmpo_hasta.toString())

        def dateFormat = "yyyy-MM-dd HH:mm"
        def dateString = "${res.tmpo_hasta.toString()}"
        def date = Date.parse(dateFormat, dateString)

        render date.format("dd-MM-yyyy HH:mm")
    }

}
