<%@ page import="bitacora.Actividad" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Actividad</title>
</head>

<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link action="form" class="btn btn-default btnCrear">
            <i class="fa fa-file"></i> Crear Actividad
        </g:link>
    </div>

%{--    <div class="btn-group pull-right col-md-3">--}%
%{--        <div class="input-group">--}%
%{--            <input type="text" class="form-control" placeholder="Buscar" value="${params.search}">--}%
%{--            <span class="input-group-btn">--}%
%{--                <g:link action="list" class="btn btn-default btn-search" type="button">--}%
%{--                    <i class="fa fa-search"></i>&nbsp;--}%
%{--                </g:link>--}%
%{--            </span>--}%
%{--        </div><!-- /input-group -->--}%
%{--    </div>--}%
</div>

<table class="table table-condensed table-bordered table-striped" style="margin-top: 15px">
    <thead>
    <tr>

        <th>Actividad Principal</th>

        <g:sortableColumn property="descripcion" title="Descripción"/>

        <g:sortableColumn property="fechaInicio" title="Fecha inicio"/>

        <g:sortableColumn property="fechaFin" title="Fecha fin"/>

        <g:sortableColumn property="horas" title="Horas prog."/>

        <g:sortableColumn property="tiempo" title="Tiempo real"/>

    </tr>
    </thead>
    <tbody>
    <g:each in="${actividadInstanceList}" status="i" var="actividadInstance">
        <tr data-id="${actividadInstance.id}">

            %{--<td>${fieldValue(bean: actividadInstance, field: "padre")}</td>--}%
            <td>${actividadInstance?.padre?.descripcion}</td>

            <td>${fieldValue(bean: actividadInstance, field: "descripcion")}</td>

            <td><g:formatDate date="${actividadInstance.fechaInicio}" format="dd-MM-yyyy"/></td>

            <td><g:formatDate date="${actividadInstance.fechaFin}" format="dd-MM-yyyy"/></td>

            <td>${fieldValue(bean: actividadInstance, field: "horas")}</td>

            <td>${fieldValue(bean: actividadInstance, field: "tiempo")}</td>

        </tr>
    </g:each>
    </tbody>
</table>

<elm:pagination total="${actividadInstanceCount}" params="${params}"/>

<script type="text/javascript">
    var id = null;
    function submitForm() {
        var $form = $("#frmActividad");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type: "POST",
                url: '${createLink(controller: 'actividad', action:'save_ajax')}',
                data: $form.serialize(),
                success: function (msg) {
                    var parts = msg.split("_");
                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
                        location.reload(true);
                    } else {
                        spinner.replaceWith($btn);
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }
    function deleteRow(itemId) {
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Actividad seleccionado? Esta acción no se puede deshacer.</p>",
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-trash-o'></i> Eliminar",
                    className: "btn-danger",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(action:'delete_ajax')}',
                            data: {
                                id: itemId
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "OK") {
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 500);
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function iniciarActv(itemId) {
        bootbox.dialog({
            title: "Iniciar actividad",
            message: "<i class='fa fa-gears fa-3x pull-left text-info text-shadow'></i>" +
              "<p>¿Está seguro que desea iniciar la Actividad seleccionada? Esta acción no se puede deshacer.</p>",
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-gears'></i> Iniciar",
                    className: "btn-info",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(action:'iniciar_ajax')}',
                            data: {
                                id: itemId
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "OK") {
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 500);
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function finalizarActv(itemId) {
        bootbox.dialog({
            title: "Finalizar actividad",
            message: "<i class='fa fa-check fa-3x pull-left text-info text-shadow'></i>" +
              "<p>¿Está seguro que desea poner como finalizada la Actividad seleccionada? Esta acción no se puede deshacer.</p>",
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-check'></i> Finalizar",
                    className: "btn-info",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(action:'finalizar_ajax')}',
                            data: {
                                id: itemId
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "OK") {
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 500);
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id: id} : {};
        $.ajax({
            type: "POST",
            url: "${createLink(action:'form_ajax')}",
            data: data,
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgCreateEdit",
//                            class   : "long",
                    class: "large",
                    title: title + " Actividad",
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
    } //createEdit

    $(function () {

        $(".btnCrear").click(function () {
            createEditRow();
            return false;
        });

        $("tbody tr").contextMenu({
            items: {
                header: {
                    label: "Acciones",
                    header: true
                },
                ver: {
                    label: "Ver",
                    icon: "fa fa-search",
                    action: function ($element) {
                        var id = $element.data("id");
                        $.ajax({
                            type: "POST",
                            url: "${createLink(action:'show_ajax')}",
                            data: {
                                id: id
                            },
                            success: function (msg) {
                                bootbox.dialog({
                                    title: "Ver",
                                    message: msg,
                                    buttons: {
                                        ok: {
                                            label: "Aceptar",
                                            className: "btn-primary",
                                            callback: function () {
                                            }
                                        }
                                    }
                                });
                            }
                        });
                    }
                },
                editar: {
                    label: "Editar",
                    icon: "fa fa-pencil",
                    action: function ($element) {
                        var id = $element.data("id");
                        createEditRow(id);
                    }
                },
                iniciar: {
                    label: "Iniciar",
                    icon: "fa fa-gears",
                    separator_before: true,
                    action: function ($element) {
                        var id = $element.data("id");
                        iniciarActv(id);
                    }
                },
                finalizar: {
                    label: "Finalizar",
                    icon: "fa fa-check",
                    separator_before: true,
                    action: function ($element) {
                        var id = $element.data("id");
                        finalizarActv(id);
                    }
                },
                eliminar: {
                    label: "Eliminar",
                    icon: "fa fa-trash-o",
                    separator_before: true,
                    action: function ($element) {
                        var id = $element.data("id");
                        deleteRow(id);
                    }
                }
            },
            onShow: function ($element) {
                $element.addClass("trHighlight");
            },
            onHide: function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });

    });
</script>

</body>
</html>
