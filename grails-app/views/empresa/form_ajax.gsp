<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 30/10/20
  Time: 11:01
--%>

<%@ page import="bitacora.Empresa" %>

<g:if test="${!empresa}">
    <elm:notFound elem="Empresa" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmEmpresa" role="form" action="save_ajax" method="POST" useToken="true">
        <g:hiddenField name="id" value="${empresa?.id}" />

        <div class="form-group ${hasErrors(bean: empresa, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-8">
                    <g:textField name="nombre" maxlength="255" required="" class="form-control required" value="${empresa?.nombre}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: empresa, field: 'ruc', 'error')} ">
            <span class="grupo">
                <label for="ruc" class="col-md-2 control-label text-info">
                    RUC
                </label>
                <div class="col-md-4">
                    <g:textField name="ruc" maxlength="13" required="" class="form-control required" value="${empresa?.ruc}"/>
                </div>
            </span>
            <span class="grupo">
                <label for="sigla" class="col-md-2 control-label text-info">
                    Sigla
                </label>
                <div class="col-md-4">
                    <g:textField name="sigla" maxlength="7"  class="form-control" value="${empresa?.sigla}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: empresa, field: 'direccion', 'error')} ">
            <span class="grupo">
                <label for="direccion" class="col-md-2 control-label text-info">
                    Dirección
                </label>
                <div class="col-md-8">
                    <g:textArea name="direccion" maxlength="255" required="" class="form-control" value="${empresa?.direccion}" style="resize: none;"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: empresa, field: 'sigla', 'error')} ">

        </div>

        <div class="form-group ${hasErrors(bean: empresa, field: 'telefono', 'error')} ">
            <span class="grupo">
                <label for="telefono" class="col-md-2 control-label text-info">
                    Teléfono
                </label>
                <div class="col-md-4">
                    <g:textField name="telefono" maxlength="63"  class="form-control number" value="${empresa?.telefono}"/>
                </div>
            </span>

            <span class="grupo">
                <label for="mail" class="col-md-2 control-label text-info">
                    Mail
                </label>
                <div class="col-md-4">
                    <g:textField name="mail" maxlength="63"  class="form-control email" value="${empresa?.mail}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: empresa, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label for="observaciones" class="col-md-2 control-label text-info">
                    Observaciones
                </label>
                <div class="col-md-8">
                    <g:textArea name="observaciones" maxlength="255"  class="form-control" value="${empresa?.observaciones}"  style="resize: none;"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: empresa, field: 'fechaInicio', 'error')} ">
            <span class="grupo">
                <label for="fechaInicio" class="col-md-2 control-label text-info">
                    Fecha de inicio
                </label>
                <div class="col-md-4">
                    <div class="container">
                        <div class="form-group">
                            <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control" value="${empresa?.fechaInicio?.format("dd-MM-yyyy")}"/>
                        </div>
                    </div>
                </div>
            </span>

            <span class="grupo">
                <label for="fechaFin" class="col-md-2 control-label text-info">
                    Fecha de finalización
                </label>
                <div class="col-md-4" style="font-size: 14px">
                    <input name="fechaFin" id='datetimepicker2' type='text' class="form-control" value="${empresa?.fechaFin?.format("dd-MM-yyyy")}"/>
                </div>
            </span>
        </div>

    </g:form>

    <script type="text/javascript">

        $(function () {
            $('#datetimepicker1').datetimepicker({
                locale: 'es',
                format: 'DD-MM-YYYY',
                // daysOfWeekDisabled: [0, 6],
                // sideBySide: true,  /* false: muestra separado horas y días */
                showClose: true,
                icons: {
                    close: 'cerrar'
                }
            });
        });

        $(function () {
            $('#datetimepicker2').datetimepicker({
                locale: 'es',
                format: 'DD-MM-YYYY',
                // daysOfWeekDisabled: [0, 6],
                // sideBySide: true,  /* false: muestra separado horas y días */
                showClose: true,
                icons: {
                    close: 'cerrar'
                }
            });
        });


        var validator = $("#frmEmpresa").validate({
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
            }
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    </script>

</g:else>