<%@ page import="bitacora.Actividad" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!actividadInstance}">
    <elm:notFound elem="Actividad" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmActividad" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${actividadInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: actividadInstance, field: 'padre', 'error')} ">
            <span class="grupo">
                <label for="padre" class="col-md-2 control-label text-info">
                    Actividad principal
                </label>
                <div class="col-md-10">
                    <g:select id="padre" name="padre.id" from="${bitacora.Actividad.list()}" optionKey="id"
                        optionValue="${{it?.descripcion?.size() < 60 ? it?.descripcion : (it?.descripcion[0..60] + "...")}}"
                              value="${actividadInstance?.padre?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: actividadInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Actividad a realizar:
                </label>
                <div class="col-md-10">
                    <g:textArea name="descripcion" cols="40" rows="2" maxlength="255" required="" class="form-control required" value="${actividadInstance?.descripcion}"/>
                </div>
            </span>
        </div>
        

        <div class="form-group ${hasErrors(bean: actividadInstance, field: 'horas', 'error')} ">
            <span class="grupo">
                <label for="horas" class="col-md-2 control-label text-info">
                    Tiempo estimado
                </label>
                <div class="col-md-2">
                    <g:field name="horas" type="number" value="${actividadInstance.horas}" class="digits form-control required" required="*"/>
                    <span>horas</span>
                </div>

                <label for="responsable" class="col-md-2 control-label text-info">
                    Responsable
                </label>
                <div class="col-md-6">
                    <g:select id="responsable" name="responsable.id" from="${seguridad.Persona.list()}" optionKey="id"
                              optionValue="${{it.nombre + ' ' + it.apellido}}"
                              required="" value="${actividadInstance?.responsable?.id}" class="many-to-one form-control"/>
                </div>
            </span>
        </div>

%{--
        <div class="form-group ${hasErrors(bean: actividadInstance, field: 'fechaRegistro', 'error')} ">
            <span class="grupo">
                <label for="fechaInicio" class="col-md-2 control-label text-info">
                    Fecha de inicio
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fechaInicio"  class="datepicker form-control" value="${actividadInstance?.fechaInicio}"  />
                </div>
            </span>
            <span class="grupo">
                <label for="fechaFin" class="col-md-2 control-label text-info">
                    Fecha de finalización
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fechaFin"  class="datepicker form-control" value="${actividadInstance?.fechaFin}"  />
                </div>
            </span>
        </div>
--}%


        <div class="form-group ${hasErrors(bean: actividadInstance, field: 'prioridad', 'error')} ">
            <span class="grupo">
                <label for="prioridad" class="col-md-2 control-label text-info">
                    Prioridad
                </label>
                <div class="col-md-4">
                    <g:select id="prioridad" name="prioridad.id" from="${bitacora.Prioridad.list()}" optionKey="id" required="" value="${actividadInstance?.prioridad?.id?:3}" class="many-to-one form-control"/>
                </div>
            </span>

            <span class="grupo">
                <label for="avance" class="col-md-3 control-label text-info">
                    Avance
                </label>
                <div class="col-md-3">
                    <g:field name="avance" type="number" value="${actividadInstance.avance}" class="digits form-control required" required=""/>
                </div>
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: actividadInstance, field: 'avance', 'error')} ">
            <span class="grupo">
                <label for="como" class="col-md-2 control-label text-info">
                    Indicaciones
                </label>
                <div class="col-md-10">
                    <g:textField name="como" class="form-control" value="${actividadInstance?.como}"/>
                </div>

            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: actividadInstance, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label for="observaciones" class="col-md-2 control-label text-info">
                    Observaciones
                </label>
                <div class="col-md-10">
                    <g:textField name="observaciones" class="form-control" value="${actividadInstance?.observaciones}"/>
                </div>
                
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmActividad").validate({
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