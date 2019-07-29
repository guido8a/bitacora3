<%@ page import="seguridad.Persona" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Búsqueda de Actividades</title>

    <style type="text/css">

    .alinear {
        text-align : center !important;
    }

    #buscar {
        width: 400px;
        border-color: #37ad7d;
    }
    #limpiaBuscar {
        position: absolute;
        right: 5px;
        top: 0;
        bottom: 0;
        height: 14px;
        margin: auto;
        font-size: 14px;
        cursor: pointer;
        color: #ccc;
    }
    </style>

</head>

<body>
<div style="min-height: 60px" class="vertical-container">
    <p class="css-vertical-text"></p>

    <div class="linea"></div>

    <div>
        <div class="col-md-12">
            Buscar actividades por:
            <div class="btn-group">
                <input id="buscar" type="search" class="form-control">
                %{--                <span id="limpiaBuscar" class="fa fa-times-circle" title="Limpiar texto de búsqueda"></span>--}%

            </div>
            <a href="#" name="busqueda" class="btn btn-success btnBusqueda btn-ajax"><i class="fa fa-search"></i> Buscar</a>
            <a href="#" name="lb" class="limpiaBuscar btn btn-info"><i class="fa fa-eraser"></i> Limpiar</a>
        </div>
    </div>
</div>

<div style="margin-top: 30px; min-height: 660px" class="vertical-container">
    <p class="css-vertical-text">Resultado - Buscar en Actividades</p>
    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr>
            <th class="alinear"  style="width: 80px">Prioridad</th>
            <th class="alinear"  style="width: 270px">Actividad Padre</th>
            <th class="alinear"  style="width: 350px">Actividad</th>
            <th class="alinear" style="width: 100px">Responsable</th>
            <th class="alinear" style="width: 50px">Horas</th>
            <th class="alinear" style="width: 50px">Real</th>
            <th class="alinear" style="width: 80px">Inicio</th>
            <th class="alinear" style="width: 90px">Fin</th>
        </tr>
        </thead>
    </table>

    <div id="bandeja">
    </div>
</div>

<div><strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retorna como máximo 20 <span class="text-info" style="margin-left: 40px">Se ordena por grado de relevancia</span>
</div>

<div class="modal fade " id="dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Detalles</h4>
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

    function submitForm() {
        var $form = $("#frmActividad");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'actividad', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
                        cargarBandeja();
                    } else {
                        // spinner.replaceWith($btn);
                        cargarBandeja();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }


    function cargarBandeja(){
        $("#bandeja").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
        var buscar = $("#buscar").val();
        var datos = "buscar=" + buscar;
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'buscarActividad', action: 'tablaBusquedaActv')}",
            data    : datos,
            success : function (msg) {
                $("#bandeja").html(msg);
            },
            error   : function (msg) {
                $("#bandeja").html("Ha ocurrido un error");
            }
        });
    }

    $(".btnBusqueda").click(function () {
        cargarBandeja();
    });

    $("input").keyup(function (ev) {
        if (ev.keyCode == 13) {
            $(".btnBusqueda").click();
        }
    });


    function createContextMenu(node) {
        var $tr = $(node);
        var data = id ? { id: id } : {};

        var items = {
            header : {
                label  : "Acciones",
                header : true
            }
        };

        var id = $tr.data("id");

        var ver = {
            label  : 'Ver',
            icon   : "fa fa-search",
            action : function (e) {
                $("#dialog-body").html(spinner);
                $.ajax({
                    type    : 'POST',
                    url     : '${createLink(controller: 'actividad', action: 'show_ajax')}',
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        $("#dialog-body").html(msg)
                    }
                });
                $("#dialog").modal("show");
            }
        };

        var editar = {
            label  : 'Editar actividad',
            icon   : "fa fa-pen",
            action : function (e) {
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller: 'actividad', action:'form_ajax')}",
                    data: {id: id},
                    success: function (msg) {
                        var b = bootbox.dialog({
                            id: "dlgCreateEdit",
//                            class   : "long",
                            class: "large",
                            title: "Editar Actividad",
                            message: msg,
                            buttons: {
                                cancelar: {
                                    label: "Cancelar",
                                    className: "btn-primary",
                                    callback: function () {
                                    }
                                },
                                guardar: {
                                    id: "btnSave",
                                    label: "<i class='fa fa-save'></i> Guardar",
                                    className: "btn-success",
                                    callback: function () {
                                        return submitForm();
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            }
        };

        var nuevo = {
            label  : 'Crear actividad',
            icon   : "fa fa-cogs",
            action : function (e) {
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller: 'actividad', action:'form_ajax')}",
//                            data: data,
                    success: function (msg) {
                        var b = bootbox.dialog({
                            id: "dlgCreateEdit",
//                            class   : "long",
                            class: "large",
                            title: "Crear Actividad",
                            message: msg,
                            buttons: {
                                cancelar: {
                                    label: "Cancelar",
                                    className: "btn-primary",
                                    callback: function () {
                                    }
                                },
                                guardar: {
                                    id: "btnSave",
                                    label: "<i class='fa fa-save'></i> Guardar",
                                    className: "btn-success",
                                    callback: function () {
                                        return submitForm();
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            }
        };


        items.ver = ver;
        items.editar = editar;
        items.nuevo = nuevo;

        return items
    }

    $(".limpiaBuscar").click(function () {
        $("#buscar").val("");
    });


</script>

</body>
</html>