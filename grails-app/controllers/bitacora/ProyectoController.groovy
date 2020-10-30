package bitacora


class ProyectoController {

    def list(){

    }

    def form_ajax(){
        def proyecto
        if(params.id){
            proyecto = Proyecto.get(params.id)
        }else{
            proyecto = new Proyecto()
        }

        return[proyecto:proyecto]
    }

    def tablaProyecto_ajax() {
        def proyectos = Proyecto.list().sort{it.descripcion}
        return[proyectos: proyectos]
    }

    def save_ajax(){

        def proyecto

        if(params.id){
            proyecto = Proyecto.get(params.id)
        }else{
            proyecto = new Proyecto()
        }

        proyecto.properties = params

        if(!proyecto.save(flush:true)){
            println("error al guardar el proyecto " + proyecto.errors)
            render "no"
        }else{
            render "ok"
        }

    }

    def show_ajax(){
        def proyecto
        if(params.id){
            proyecto = Proyecto.get(params.id)
        }else{
            proyecto = new Proyecto()
        }

        return[proyecto:proyecto]
    }

    def borrar_ajax(){
        def proyecto = Proyecto.get(params.id)

        try{
            proyecto.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el proyecto " + proyecto.errors)
            render "no"
        }
    }

}
