<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 30/10/20
  Time: 11:01
--%>

<%@ page import="bitacora.Proyecto" %>

<g:if test="${!proyecto}">
    <elm:notFound elem="Proyecto" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmProyecto" role="form" action="save_ajax" method="POST" useToken="true">
        <g:hiddenField name="id" value="${proyecto?.id}" />

        <div class="form-group ${hasErrors(bean: proyecto, field: 'empresa', 'error')} ">
            <span class="grupo">
                <label for="empresa" class="col-md-2 control-label text-info">
                    Empresa
                </label>
                <div class="col-md-8">
                   <g:select name="empresa" from="${bitacora.Empresa.list()}" optionValue="nombre" optionKey="id" required="" class="form-control required" value="${proyecto?.empresa?.id}"/>
                </div>
            </span>
        </div>


        <div class="form-group ${hasErrors(bean: proyecto, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-8">
                    <g:textField name="descripcion" maxlength="63" required="" class="form-control required" value="${proyecto?.descripcion}" />
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: proyecto, field: 'responsable', 'error')} ">
            <span class="grupo">
                <label for="responsable" class="col-md-2 control-label text-info">
                    Responsable
                </label>
                <div class="col-md-8">
                    <g:textField name="responsable" maxlength="63" required="" class="form-control" value="${proyecto?.responsable}" />
                </div>
            </span>
        </div>


        <div class="form-group ${hasErrors(bean: proyecto, field: 'telefono', 'error')} ">
            <span class="grupo">
                <label for="telefono" class="col-md-2 control-label text-info">
                    Teléfono
                </label>
                <div class="col-md-4">
                    <g:textField name="telefono" maxlength="63"  class="form-control number" value="${proyecto?.telefono}"/>
                </div>
            </span>

            <span class="grupo">
                <label for="mail" class="col-md-2 control-label text-info">
                    Mail
                </label>
                <div class="col-md-4">
                    <g:textField name="mail" maxlength="63"  class="form-control email" value="${proyecto?.mail}"/>
                </div>
            </span>
        </div>


    </g:form>

    <script type="text/javascript">

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