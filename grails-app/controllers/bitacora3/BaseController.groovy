package bitacora3

import bitacora.Base
import bitacora.Imagen
import bitacora.Tema
import groovy.json.JsonBuilder
import org.grails.core.io.ResourceLocator
import seguridad.Persona

import grails.config.Config
import grails.core.support.GrailsConfigurationAware
import groovy.transform.CompileStatic

import grails.core.GrailsApplication


class BaseController extends seguridad.Shield {

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
            def c = Base.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Base.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def baseInstanceList = getLista(params, false)
        def baseInstanceCount = getLista(params, true).size()
        if (baseInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        baseInstanceList = getLista(params, false)
        return [baseInstanceList: baseInstanceList, baseInstanceCount: baseInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def baseInstance = Base.get(params.id)
            if (!baseInstance) {
                notFound_ajax()
                return
            }
            return [baseInstance: baseInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def baseInstance = new Base(params)
        if (params.id) {
            baseInstance = Base.get(params.id)
            if (!baseInstance) {
                notFound_ajax()
                return
            }
        }
        return [baseInstance: baseInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def baseInstance = new Base()
        if (params.id) {
            baseInstance = Base.get(params.id)
            if (!baseInstance) {
                notFound_ajax()
                return
            }
        } //update
        baseInstance.properties = params
        if (!baseInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Base."
            msg += renderErrors(bean: baseInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Base exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def baseInstance = Base.get(params.id)
            if (baseInstance) {
                try {
                    baseInstance.delete(flush: true)
                    render "OK_Eliminación de Base exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Base."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Base."
    } //notFound para ajax

    def base () {
        def base = Base.get(params.id)
        return [base: base]
    }

    def guardarProblema_ajax () {
//        println("guardarProblema params: " + params)

        def tema = Tema.get(params.tema)
        def usuario = Persona.get(session.usuario.id)
        def baseInstance
        def edita = params.id? params.id : 0

        if(params.id){
            baseInstance = Base.get(params.id)
        } else {
            baseInstance = new Base()
            baseInstance.fecha = new Date()
            baseInstance.persona = usuario

        }
        baseInstance.properties = params
        baseInstance.tema = tema

//        println "edita: $edita"
        try{
            println "...1"
            baseInstance.save(flush: true)
//            println "guardado ----- "
            baseInstance.refresh()
            println "....id: ${baseInstance.id}"
            render "ok_${baseInstance.id}"


/*
            if(!edita) {
                params.id = baseInstance.id
                redirect (action: "base", params: params)
            }
*/

        } catch (e) {
            println("error al guardar el problema " + baseInstance.errors)
            render "no"
        }

    }


    def validarProblema_ajax () {
        def problema = params.problema

        if(problema.size() < 15){
           render false
            return
        }else{
            render true
            return
        }
    }

    def validarClave_ajax () {
        def clave = params.clave

        if(clave.size() < 3){
            render false
            return
        }else{
            render true
            return
        }
    }

    def ver_ajax() {
        println "ver ajax: params: $params"
        render view: 'show_ajax', model: [baseInstance: Base.get(params.id)]
    }


    def carrusel_ajax () {

        println("params carrusel " + params)

        def base = Base.get(params.id)
        def listaImagenes = Imagen.findAllByBase(base)
//        def directorio = '/home/fabricio/imas/' + base?.id + "/"
//        def directorio = '/static/imagenes/' + base?.id + "/"

        Config config = grailsApplication.config
//        def p = config.getProperty("grails.nuevoPath.nuevo")
        def p = "/var/bitacora/"

        def directorio = p + base?.id + "/"

        println("directorio " + directorio)

        return [listaImagenes: listaImagenes, directorio: directorio, base: base]

    }

    void setConfiguration(Config co) {
        def cdnFolder = co.getRequiredProperty('grails.guides.cdnFolder')
        def cdnRootUrl = co.getRequiredProperty('grails.guides.cdnRootUrl')
    }

    def subirImagen () {

        println("params subir imagen " + params)

        def base = Base.get(params.id)

        def anio = new Date().format("yyyy")
//        def path = servletContext.getRealPath("/") + "/imagenes/"
//        def path = servletContext.getRealPath("/")

//        String folderPath = "${cdnFolder}/pointOfInterest/${params.id}"

//        def cdnFolder = config.getRequiredProperty("grails.guides.cdnFolder")
//        def cdnFolder = grailsApplication.config.getProperty("grails.guides.cdnFolder")
//        def cdnFolder = grailsApplication.config.getProperty("grails.nuevoPath")
//        def cdnFolder = '/grails-app/images/assets/apli'



//        def cdnFolder = "/home/fabricio/IdeaProjects/bitacora3/grails-app/assets/images/apli"
        def cdnFolder = "/var/bitacora"
        def path = cdnFolder + "/${params.id}/"

        println "folder : $path"
//        File folder = new File(folderPath)
        File folder = new File(path)

        if ( !folder.exists() ) {
            folder.mkdirs()
        }


        def f = request.getFile('file')  //archivo = name del input type file


//        def imageContent = ['image/png': "png", 'image/jpeg': "jpeg", 'image/jpg': "jpg"]
        def okContents = [
                'image/png'                                                                : "png",
                'image/jpeg'                                                               : "jpeg",
                'image/jpg'                                                                : "jpg"
        ]

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                }
            }

//            if (okContents.containsKey(f.getContentType())) {
                ext = okContents[f.getContentType()]
                fileName = fileName.size() < 40 ? fileName : fileName[0..39]
                fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")

                def nombre = fileName + "." + ext
                def pathFile = path + nombre
                println("---->" + pathFile)
                def fn = fileName
                def src = new File(pathFile)
                def i = 1
                while (src.exists()) {
                    nombre = fn + "_" + i + "." + ext
                    pathFile = path + nombre
                    src = new File(pathFile)
                    i++
                }
                try {
                    f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                } catch (e) {
                    println "----Error\n" + e + "\n-----"
                }

                def imagen = new Imagen([
                        base: base,
                        descripcion  : params.descripcion.toString(),
                        ruta      : nombre
                ])
                def data
                if (imagen.save(flush: true)) {
                    data = [
                            files: [
                                    [
                                            name: nombre,
                                            size: f.getSize(),
                                            url : pathFile
                                    ]
                            ]
                    ]
                } else {
                    println "error al guardar: " + imagen.errors
                    data = [
                            files: [
                                    [
                                            name : nombre,
                                            size : f.getSize(),
                                            error: "Ha ocurrido un error al guardar: " + renderErrors(bean: imagen)
                                    ]
                            ]
                    ]
                }
                def json = new JsonBuilder(data)
                render json

        } //f && !f.empty




    }





//
//    @SuppressWarnings('GrailsStatelessService')
//    @CompileStatic
//    class UploadPointOfInterestFeaturedImageService implements GrailsConfigurationAware {
//
//        Imagen pointOfInterestDataService
//
//        String cdnFolder
//        String cdnRootUrl
//
//        @Override
//        void setConfiguration(Config co) {
//            cdnFolder = co.getRequiredProperty('grails.guides.cdnFolder')
//            cdnRootUrl = co.getRequiredProperty('grails.guides.cdnRootUrl')
//        }
//
//        @SuppressWarnings('JavaIoPackageAccess')
//        Imagen uploadFeatureImage(FeaturedImageCommand cmd) {
//
//            String filename = cmd.featuredImageFile.originalFilename
//            String folderPath = "${cdnFolder}/pointOfInterest/${cmd.id}"
//            File folder = new File(folderPath)
//            if ( !folder.exists() ) {
//                folder.mkdirs()
//            }
//            String path = "${folderPath}/${filename}"
//            cmd.featuredImageFile.transferTo(new File(path))
//
//            String featuredImageUrl = "${cdnRootUrl}//pointOfInterest/${cmd.id}/${filename}"
//            Imagen poi = pointOfInterestDataService.updateFeaturedImageUrl(cmd.id, cmd.version, featuredImageUrl)
//
//            if ( !poi || poi.hasErrors() ) {
//                File f = new File(path)
//                f.delete()
//            }
//            poi
//        }
//    }



}
