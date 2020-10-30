<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 30/10/20
  Time: 11:00
--%>

<%@ page import="seguridad.Persona" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de proyectos</title>

    <style type="text/css">

    </style>

</head>

<body>

<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <a href="#" class="btn btn-success" id="btnCrearProyecto">
            <i class="fa fa-file"></i> Nuevo proyecto
        </a>
    </div>
</div>

<div style="margin-top: 30px; min-height: 400px" class="vertical-container">
    <p class="css-vertical-text">Proyectos</p>
    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr style="width: 100%">
            <th class="alinear" style="width: 10%">Empresa</th>
            <th class="alinear"  style="width: 40%">Descripción</th>
            <th class="alinear"  style="width: 30%">Responsable</th>
            <th class="alinear"  style="width: 10%">Teléfono</th>
            <th class="alinear" style="width: 10%">Mail</th>
        </tr>
        </thead>
    </table>

    <div id="bandeja">
    </div>
</div>


<script type="text/javascript">

    $("#btnCrearProyecto").click(function () {
        createEditRow();
    });

    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'proyecto', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Proyecto",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
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
    } //createEdit

    cargarBandeja();

    function submitForm() {
        var $form = $("#frmProyecto");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'proyecto', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    if (msg== "ok") {
                        log("Proyecto guardada correctamente","success");
                        setTimeout(function () {
                            cargarBandeja();
                        }, 500);
                    } else {
                        log("Error al guardar el proyecto","error");
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
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'proyecto', action: 'tablaProyecto_ajax')}",
            data    : {
            },
            success : function (msg) {
                $("#bandeja").html(msg);
            },
            error   : function (msg) {
                $("#bandeja").html("Ha ocurrido un error");
            }
        });
    }


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
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: 'proyecto', action:'show_ajax')}",
                    data    : {
                        id:id
                    },
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgVer",
                            title   : "Datos del proyecto",
                            message : msg,
                            buttons : {
                                cancelar : {
                                    label     : "Cerrar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            } //buttons
                        }); //dialog
                    } //success
                }); //ajax
            }
        };

        var editar = {
            label  : 'Editar',
            icon   : "fa fa-pen",
            action : function (e) {
                createEditRow(id);
            }
        };

        var borrar = {
            label  : 'Borrar',
            icon   : "fa fa-trash",
            action : function (e) {
                bootbox.confirm("<strong>" + "Está seguro de borrar este proyecto?" + "</strong>", function (result) {
                    if (result) {
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'proyecto', action:'borrar_ajax')}',
                            data    : {
                                id: id
                            },
                            success : function (msg) {
                                if (msg== "ok") {
                                    log("Proyecto borrado correctamente","success");
                                    setTimeout(function () {
                                        cargarBandeja();
                                    }, 500);
                                } else {
                                    log("Proyecto al borrar la empresa","error");
                                    cargarBandeja();
                                    return false;
                                }
                            }
                        });
                    }
                })

            }
        };


        items.ver = ver;
        items.editar = editar;
        items.borrar = borrar;

        return items
    }


</script>

</body>
</html>