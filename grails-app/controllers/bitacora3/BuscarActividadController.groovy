package bitacora3

class BuscarActividadController {


    def dbConnectionService
    def tramitesService

    def busquedaActividad() {
//        println "busqueda "
    }

    def tablaBusquedaActv() {
//        println "buscarActv .... $params"
        def persona = session.usuario.id
        def data
        def cn = dbConnectionService.getConnection()
        def sql = "select ac.actv__id id, prdddscr prioridad, pdre.actvdscr padre, ac.actvdscr descripcion, " +
                "prsnnmbr||' '||prsnapll responsable, ac.actvhora horas, ac.actvtmpo tiempo, ac.actvfcha, ac.actvfcin, ac.actvfcfn, ac.actvavnc " +
                "from actv ac left join actv pdre on pdre.actv__id = ac.actvpdre, prsn, prdd " +
                "where prdd.prdd__id = ac.prdd__id and ac.actvdscr ilike '%${params.buscar}%' and " +
                " prsn.prsn__id = ac.prsnpara and prdd.prdd__id = ac.prdd__id " +
                "order by ac.actvfcha, ac.actvdscr limit 21"

        println "sql: $sql"

        data = cn.rows(sql)

        def resultado = data
//        println "resultado: $resultado"
        def msg = ""
        if (resultado.size() > 20) {
            resultado = resultado[0..19]
            msg = "<div class='alert alert-danger'> <i class='fa fa-warning fa-2x pull-left'></i> Su búsqueda ha generado más de 20 resultados. Use más palabras para especificar mejor la búsqueda.</div>"
        }
        return [actividades: resultado, persona: persona, msg: msg]
    }

    def busquedaEnviados() {
    }

}
