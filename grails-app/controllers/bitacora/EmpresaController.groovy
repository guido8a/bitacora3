package bitacora



class EmpresaController {

    def list(){

    }

    def form_ajax(){
        def empresa
        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = new Empresa()
        }

        return[empresa:empresa]
    }

    def tablaEmpresa_ajax() {
        def empresas = Empresa.list().sort{it.nombre}
        return[empresas: empresas]
    }

    def save_ajax(){

        def empresa

        if(params.fechaInicio){
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }

        if(params.fechaFin){
            params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)
        }

        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = new Empresa()
        }

        empresa.properties = params

        if(!empresa.save(flush:true)){
            println("error al guardar la empresa " + empresa.errors)
            render "no"
        }else{
            render "ok"
        }

    }

    def show_ajax(){
        def empresa
        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = new Empresa()
        }

        return[empresa:empresa]
    }

    def borrar_ajax(){
        def empresa = Empresa.get(params.id)

        try{
            empresa.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar la empresa " + empresa.errors)
            render "no"
        }
    }
}
