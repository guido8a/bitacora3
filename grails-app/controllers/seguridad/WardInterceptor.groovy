package seguridad


class WardInterceptor {

    WardInterceptor () {
        matchAll().excludes(controller: 'login')
    }

    boolean before() {
        println "acción: " + actionName + " controlador: " + controllerName + " params: $params"
//        println "shield sesión: " + session
//        println "usuario: " + session.usuario
        session.an = actionName
        session.cn = controllerName
        session.pr = params

        if(session.an == 'saveTramite' && session.cn == 'tramite'){
            println("entro")
            return true
        } else {
            if (!session.usuario || !session.perfil) {
                if(controllerName != "inicio" && actionName != "index") {
                    flash.message = "Usted ha superado el tiempo de inactividad máximo de la sesión"
                }
//                render grailsLinkGenerator.link(controller: 'login', action: 'login', absolute: true)
                redirect(controller: 'login', action: 'login')
                session.finalize()
                return false
            } else {
                def usu = Persona.get(session.usuario.id)
                if (usu.estaActivo) {
                    session.departamento = Departamento.get(session.departamento.id).refresh()
                    def perms = session.usuario.permisos
                    session.usuario = Persona.get(session.usuario.id).refresh()
                    session.usuario.permisos = perms

                    if (!isAllowed()) {
                        redirect(controller: 'shield', action: 'unauthorized')
                        return false
                    }

                } else {
                    println "session.flag: " + session.flag
                    if (!session.flag || session.flag < 1) {
//                    println "menor que cero "+session.flag
                        session.usuario = null
                        session.perfil = null
                        session.permisos = null
                        session.menu = null
                        session.an = null
                        session.cn = null
                        session.invalidate()
                        session.flag = null
                        session.finalize()
                        redirect(controller: 'login', action: 'login')
                        return false
                    } else {
                        session.flag = session.flag - 1
                        session.departamento = Departamento.get(session.departamento.id).refresh()
                        return true
                    }
                }
            }
        }

        true
    }

    boolean after() {
        println "+++++después"
        true
    }

    void afterView() {
        println "+++++afterview"
        // no-op
    }


    boolean isAllowed() {
//        try {
//            if (request.method == "POST") {
////                println "es post no audit"
//                return true
//            }
////            println "is allowed Accion: ${actionName.toLowerCase()} ---  Controlador: ${controllerName.toLowerCase()} --- Permisos de ese controlador: "+session.permisos[controllerName.toLowerCase()]
//            if (!session.permisos[controllerName.toLowerCase()]) {
//                return false
//            } else {
//                if (session.permisos[controllerName.toLowerCase()].contains(actionName.toLowerCase())) {
//                    return true
//                } else {
//                    return false
//                }
//            }
//
//        } catch (e) {
//            println "Shield execption e: " + e
//            return false
//        }
//            return false
        return true

    }

}
