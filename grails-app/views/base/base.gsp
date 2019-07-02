<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta name="layout" content="main">
    <title>Bitácora - Artículo</title>
    <script src="${resource(dir: 'js/plugins/ckeditor', file: 'ckeditor.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/vendor', file: 'jquery.ui.widget.js')}"></script>
    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/imgResize', file: 'load-image.min.js')}"></script>
    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/imgResize', file: 'canvas-to-blob.min.js')}"></script>
    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.iframe-transport.js')}"></script>
    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload.js')}"></script>
    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload-process.js')}"></script>
    <script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload-image.js')}"></script>
    <link href="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/css', file: 'jquery.fileupload.css')}" rel="stylesheet">

    <style type="text/css">
    .mediano {
        margin-top: 5px;
        padding-top: 9px;
        height: 30px;
        font-size: inherit;
        /*font-size: medium;*/
        text-align: right;
    }
    .sobrepuesto {
        position: absolute;
        top: 1px;
        font-size: 14px;
    }


    .nav-tabs > li > a{
        border: medium none;

    }
    .nav-tabs > li > a:hover{
        background-color: #475563 !important;
        border: medium none;
        border-radius: 0;
        color:#fff;
        /*color:#475563 !important;;*/
    }


    .progress-bar-svt {
        border     : 1px solid #e5e5e5;
        width      : 100%;
        height     : 25px;
        background : #F5F5F5;
        padding    : 0;
        margin-top : 10px;
    }

    .progress-svt {
        width            : 0;
        height           : 23px;
        padding-top      : 5px;
        padding-bottom   : 2px;
        background-color : #428BCA;
        text-align       : center;
        line-height      : 100%;
        font-size        : 14px;
        font-weight      : bold;
    }

    .background-image {
        background-image  : -webkit-linear-gradient(45deg, rgba(255, 255, 255, .15) 10%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
        background-image  : linear-gradient(45deg, rgba(255, 255, 255, .15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .15) 50%, rgba(255, 255, 255, .15) 75%, transparent 75%, transparent);
        -webkit-animation : progress-bar-stripes-svt 2s linear infinite;
        background-size   : 60px 60px;
        animation         : progress-bar-stripes-svt 2s linear infinite;
    }

    @-webkit-keyframes progress-bar-stripes-svt {
        /*el x del from tiene que ser multiplo del x del background size...... mientas mas grande mas rapida es la animacion*/
        from {
            background-position : 120px 0;
        }
        to {
            background-position : 0 0;
        }
    }

    @keyframes progress-bar-stripes-svt {
        from {
            background-position : 120px 0;
        }
        to {
            background-position : 0 0;
        }
    }
    </style>

</head>

<body>

<div class="panel panel-primary col-md-12">

    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: right"><i class="fa fa-pencil-square"></i> Bitácora - Artículo
           "${base?.problema?.size() < 26 ? base?.problema : base?.problema[0..25]+"..."}"</h3>
        <a href="#" id="btnGuardar" class="btn btn-sm btn-success sobrepuesto" title="Guardar información">
            <i class="fa fa-save"></i> Guardar
        </a>
        <a href="#" id="btnImprimir" class="btn btn-sm btn-info sobrepuesto" style="margin-left: 94px" title="Imrpimir artículo">
            <i class="fa fa-print"></i> Imprimir
        </a>
        <a href="${createLink(controller: 'buscarBase', action: 'busquedaBase')}" id="btnConsultarr"
           class="btn btn-sm btn-primary sobrepuesto" style="margin-left: 188px" title="Consultar artículo">
            <i class="fa fa-check"></i> Consultar
        </a>
        <a href="#" id="btnBase" class="btn btn-sm btn-primary sobrepuesto"
           style="margin-left: 290px" title="Crear nuevo registro">
            <i class="fa fa-check"></i> Crear Nuevo
        </a>
        <a href="#" id="btnVer" class="btn btn-sm btn-primary sobrepuesto" style="margin-left: 410px" title="Ver registro">
            <i class="fa fa-search"></i> Ver
        </a>
    </div>


    <div class="panel-group" style="height: 730px">
        <div class="col-md-12" style="margin-top: 10px">
            <ul class="nav nav-tabs">
                <li class="active col-md-4"><a data-toggle="tab" href="#home"><h4>Problema</h4></a></li>
                <li class="col-md-4"><a data-toggle="tab" href="#imagenes"><h4>Imágenes</h4></a></li>
                <li class="col-md-4"><a data-toggle="tab" href="#videos"><h4>Videos</h4></a></li>
            </ul>

            <div class="tab-content">
                <div id="home" class="tab-pane fade in active">

                    <g:form name="frmProblema" role="form" action="guardarProblema_ajax" method="POST">
                        <div class="row">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Tema</span>
                                <div class="col-md-8">
                                    <g:select name="tema" id="temaId" from="${bitacora.Tema.list()}" optionKey="id"
                                              value="${base?.tema?.id}" optionValue="nombre" class="form-control"
                                              style="color: #3d658a"/>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Problema</span>
                                <div class="col-md-10">
                                    <span class="grupo">
                                        <g:textArea name="problema" id="prbl"  class="form-control required" maxlength="255"
                                                    style="height: 60px; resize: none" value="${base?.problema}"/>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Palabras Clave</span>
                                <div>
                                    <div class="col-md-10">
                                        <span class="grupo">
                                            <g:textField name="clave" id="clve" class="form-control required"
                                                         maxlength="127"  value="${base?.clave}" />
                                        </span>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Solución</span>
                                <div class="col-md-10">
                                    <span class="grupo">
                                        <g:textArea name="solucion" id="slcn" class="form-control required" maxlength="1023" style="height: 80px; resize: none" value="${base?.solucion}"/>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Algoritmo</span>
                                <div class="col-md-10">
                                    %{--<ckeditor:editor name="algoritmo" height="240px" width="100%" toolbar="Basico2">${base?.algoritmo}</ckeditor:editor>--}%
                                    <textArea name="algoritmo" id="algoritmo">${base?.algoritmo}</textArea>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Referencias</span>
                                <div class="col-md-10">
                                    <g:textField name="referencia" id="refe" class="form-control" maxlength="255" value="${base?.referencia}"/>
                                </div>
                            </div>
                        </div>

                        <div class="row" style="margin-bottom: 20px">
                            <div class="col-md-12">
                                <span class="col-md-2 label label-primary text-info mediano">Observaciones</span>
                                <div class="col-md-10">
                                    <g:textField name="observaciones" id="obsr" class="form-control" maxlength="255" value="${base?.observacion}"/>
                                </div>
                            </div>
                        </div>

                    </g:form>



                </div>
                %{--//tab imágenes--}%
                <div id="imagenes" class="tab-pane fade">

                <g:if test="${base?.id}">

                    <div class="row">
                        <div class="col-md-10">
                            <label class="col-md-5 control-label text-info">
                                Cargue imágenes referentes al tema: '${base?.problema}"
                            </label>
                            <div class="col-md-6">
                                <span class="btn btn-success fileinput-button" style="position: relative;height: 40px;margin-top: 10px">
                                    <i class="glyphicon glyphicon-plus"></i>
                                    <span>Seleccionar archivos</span>
                                    <input type="file" name="file" id="file" class="file" multiple accept=".jpeg, .jpg, .png">
                                </span>
                            </div>
                        </div>
                    </div>
                </g:if>

                <div style="margin-top:15px;margin-bottom: 20px" class="vertical-container" id="files">
                    <p class="css-vertical-text" id="titulo-arch" style="display: none">Imagen</p>

                    <div class="linea" id="linea-arch" style="display: none"></div>
                </div>


                <div id="divCarrusel"></div>


                </div>


                <div id="videos" class="tab-pane fade">
                    <h4>VIDEOS</h4>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade " id="dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                %{--<h4 class="modal-title">Problema y Solución</h4>--}%
                Problema y Solución..
            </div>

            <div class="modal-body" id="dialog-body" style="padding: 15px">

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>


<script type="text/javascript">

    var okContents = {
        'image/png'  : "png",
        'image/jpeg' : "jpeg",
        'image/jpg'  : "jpg"
    };


    CKEDITOR.replace( 'algoritmo', {
        height: "240px",
        customConfig: 'config.js',
        filebrowserBrowseUrl    : '${createLink(controller: "baseImagenes", action: "browser")}',
        filebrowserUploadUrl    : '${createLink(controller: "baseImagenes", action: "uploader")}'
    });

    CKEDITOR.on('instanceReady', function (ev) {
        // Prevent drag-and-drop.
        ev.editor.document.on('drop', function (ev) {
            ev.data.preventDefault(true);
        });
    });


    $("#btnBase").click(function () {
//        CKEDITOR.instances.algoritmo.setData('');
//        $("#prbl").val('');
//        $("#clve").val('');
//        $("#slcn").val('');
//        $("#refe").val('');
//        $("#obsr").val('');

        location.href="${createLink(controller: 'base', action: 'base')}"

    });

    $("#btnGuardar").click(function () {
        var $form = $("#frmProblema");
//        var texto = CKEDITOR.instances.editor1.getData();
        var texto = CKEDITOR.instances.algoritmo.getData();
        var base_id = '${base?.id}';
        if($form.valid()){
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'base', action: 'guardarProblema_ajax')}",
                data:  {
                    id: base_id,
                    algoritmo: texto,
                    tema: $("#temaId").val(),
                    problema: $("#prbl").val(),
                    clave: $("#clve").val(),
                    solucion: $("#slcn").val(),
                    referencia: $("#refe").val(),
                    observacion: $("#obsr").val()
                },
                success: function (msg) {
                    var parte = msg.split("_");
                    if(parte[0] == 'ok'){
                        log("Problema guardado correctamente","success")
                        setTimeout(function () {
                            reCargar(parte[1]);
                        }, 500);
                    }else{
                        log("Error al guardar el problema","error")
                    }
                }
            });
        }
    });

    function reCargar(id) {
//        console.log('recargar', id)
        var url = "${createLink(controller: 'base', action: 'base')}" + "/" + id
//        console.log('link', url)
        location.href = url
    }



    var validator = $("#frmProblema").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        },
        rules         : {
            problema : {
                remote: {
                    url : "${createLink(action: 'validarProblema_ajax')}",
                    type: "post",
                    data: {
                        id: $("#pr").val()
                    }
                }
            },
            clave: {
                remote: {
                    url : "${createLink(action: 'validarClave_ajax')}",
                    type: "post",
                    data: {
                        id: $("#cl").val()
                    }
                }
            }
        },
        messages      : {
            problema : {
                remote: "El número mínimo de caracteres debe ser de 25"
            },
            clave: {
                remote: "El número mínimo de caracteres debe ser de 3"
            }
        }
    });

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            submitForm();
            return false;
        }
        return true;
    });



    function createContainer() {
        var file = document.getElementById("file");
        var next = $("#files").find(".fileContainer").size();
        if (isNaN(next))
            next = 1;
        else
            next++;
        var ar = file.files[next - 1];
        var div = $('<div class="fileContainer ui-corner-all d-' + next + '">');
        var row1 = $("<div class='row resumen'>");
        var row3 = $("<div class='row botones'  style='text-align: center'>");
        var row4 = $("<div class='row'>");
        row1.append("<div class='col-md-1 etiqueta'>Descripción</div>");
        row1.append("<div class='col-md-5'><textarea maxlength='254' style='resize: none' class='form-control " + next + "' required id='descripcion' name='descripcion' cols='5' rows='5'></textarea></div>");
        row3.append(" <a href='#' class='btn btn-azul subir' style='margin-right: 15px;' clase='" + next + "'><i class='fa fa-upload'></i> Guardar Imagen</a>");
        div.append("<div class='row' style='margin-top: 0px'><div class='titulo-archivo col-md-10'><span style='color: #327BBA'>Archivo:</span> " + ar.name + "</div></div>");
        div.append(row1);
        div.append(row3);
        $("#files").append(div);
        if ($("#files").height() * 1 > 120) {
            $("#titulo-arch").show();
            $("#linea-arch").show();
        } else {
            $("#titulo-arch").hide();
            $("#linea-arch").hide();
        }
    }

    function reset() {
        $("#files").find(".fileContainer").remove()
    }

    $("#file").change(function () {
        reset();
        archivos = $(this)[0].files;
        var length = archivos.length;
        for (i = 0; i < length; i++) {
            createContainer();
        }
        boundBotones();
    });


    function boundBotones() {
        $(".subir").unbind("click");
        $(".subir").bind("click", function () {
            error = false;
            $("." + $(this).attr("clase")).each(function () {
                if ($(this).val().trim() == "") {
                    error = true;
                }
            });
            if (error) {
                bootbox.alert("La imagen debe tener una descripción")
            } else {
                /*Aqui subir*/
                upload($(this).attr("clase") * 1 - 1);
            }
        });
    }


    var request = [];
    var tam = 0;
    function upload(indice) {
        var base = "${base?.id}";
        var file = document.getElementById("file");
        var formData = new FormData();
        tam = file.files[indice];
        var type = tam.type;
        if (okContents[type]) {
            tam = tam["size"];
            var kb = tam / 1000;
            var mb = kb / 1000;
            if (mb <= 5) {
                formData.append("file", file.files[indice]);
                formData.append("id", base);
                $("." + (indice + 1)).each(function () {
                    //            console.log($(this))
                    formData.append($(this).attr("name"), $(this).val());
                });
                var rs = request.length;
                $(".d-" + (indice + 1)).addClass("subiendo").addClass("rs-" + rs);
                $(".rs-" + rs).find(".resumen").remove();
                $(".rs-" + rs).find(".botones").remove();
                $(".rs-" + rs).find(".claves").remove();
                $(".rs-" + rs).append('<div class="progress-bar-svt ui-corner-all" id="p-b"><div class="progress-svt background-image" id="p-' + rs + '"></div></div>').css({
                    height     : 100,
                    fontWeight : "bold"
                });
                request[rs] = new XMLHttpRequest();
                request[rs].open("POST", "${g.createLink(controller: 'base',action: 'subirImagen')}");


                request[rs].upload.onprogress = function (ev) {
                    var loaded = ev.loaded;
                    var width = (loaded * 100 / tam);
                    if (width > 100)
                        width = 100;
                    //        console.log(width)
                    $("#p-" + rs).css({width : parseInt(width) + "%"});
                    if ($("#p-" + rs).width() > 50) {
                        $("#p-" + rs).html("" + parseInt(width) + "%");
                    }
                };
                request[rs].send(formData);
                request[rs].onreadystatechange = function () {
                    //            console.log("rs??",rs)
                    if (request[rs].readyState == 4 && request[rs].status == 200) {
                        if ($("#files").height() * 1 > 120) {
                            $("#titulo-arch").show();
                            $("#linea-arch").show();
                        } else {
                            $("#titulo-arch").hide();
                            $("#linea-arch").hide();
                        }
                        $(".rs-" + rs).html("<i class='fa fa-check' style='color:#327BBA;margin-right: 10px'></i> " + $(".rs-" + rs).find(".titulo-archivo").html() + " subido exitosamente").css({
                            height     : 50,
                            fontWeight : "bold"
                        }).removeClass("subiendo");

                        cargarCarrusel(${base?.id})
                    }
                };
            } else {
                var $div = $(".fileContainer.d-" + (indice + 1));
                $div.addClass("bg-danger").addClass("text-danger");
                var $p = $("<div>").addClass("alert divError").html("No puede subir archivos de más de 5 megabytes");
                $div.prepend($p);
                return false;
            }
        } else {
            var $div = $(".fileContainer.d-" + (indice + 1));
            $div.addClass("bg-danger").addClass("text-danger");
            var $p = $("<div>").addClass("alert divError").html("No puede subir archivos de tipo <b>" + type + "</b>");
            $div.prepend($p);
            return false;
        }
    }


    $("#btnVer").click(function () {
        var id_base = ${base?.id}
        console.log('id:', id_base);
        $("#dialog-body").html(spinner);
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'base', action: 'ver_ajax')}',
            data: {
                id: id_base
            },
            success: function (msg) {
                $("#dialog-body").html(msg)
            }
        });
        $("#dialog").modal("show");
    });



    <g:if test="${base?.id}">
    cargarCarrusel(${base?.id});
    </g:if>


    function cargarCarrusel (idO) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(action: 'carrusel_ajax')}",
            data:{
                id: idO
            },
            success : function (msg) {
                $("#divCarrusel").html(msg);
            }
        });
    }




</script>




</body>
</html>