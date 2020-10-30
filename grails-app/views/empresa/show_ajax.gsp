<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 30/10/20
  Time: 12:31
--%>


<%@ page import="bitacora.Empresa" %>

<g:if test="${!empresa}">
    <elm:notFound elem="Empresa" genero="o" />
</g:if>
<g:else>

    <g:if test="${empresa?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            <div class="col-md-10">
                ${empresa?.nombre}
            </div>
        </div>
    </g:if>

    <g:if test="${empresa?.ruc}">
        <div class="row">
            <div class="col-md-2 text-info">
                RUC
            </div>
            <div class="col-md-10">
                ${empresa?.ruc}
            </div>
        </div>
    </g:if>

    <g:if test="${empresa?.sigla}">
        <div class="row">
            <div class="col-md-2 text-info">
                Sigla
            </div>
            <div class="col-md-10">
                ${empresa?.sigla}
            </div>
        </div>
    </g:if>

    <g:if test="${empresa?.direccion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Dirección
            </div>
            <div class="col-md-10">
                ${empresa?.direccion}
            </div>
        </div>
    </g:if>

    <g:if test="${empresa?.telefono}">
        <div class="row">
            <div class="col-md-2 text-info">
                Teléfono
            </div>
            <div class="col-md-10">
                ${empresa?.telefono}
            </div>
        </div>
    </g:if>

    <g:if test="${empresa?.mail}">
        <div class="row">
            <div class="col-md-2 text-info">
                Mail
            </div>
            <div class="col-md-10">
                ${empresa?.mail}
            </div>
        </div>
    </g:if>

    <g:if test="${empresa?.observaciones}">
        <div class="row">
            <div class="col-md-2 text-info">
                Observaciones
            </div>
            <div class="col-md-10">
                ${empresa?.observaciones}
            </div>
        </div>
    </g:if>

    <g:if test="${empresa?.fechaInicio}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha de Inicio
            </div>

            <div class="col-md-9">
                <g:formatDate date="${empresa?.fechaInicio}" format="dd-MM-yyyy" />
            </div>

        </div>
    </g:if>

    <g:if test="${empresa?.fechaFin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha de Fin
            </div>

            <div class="col-md-9">
                <g:formatDate date="${empresa?.fechaFin}" format="dd-MM-yyyy" />
            </div>

        </div>
    </g:if>



</g:else>