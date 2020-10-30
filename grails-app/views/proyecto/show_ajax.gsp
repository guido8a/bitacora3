<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 30/10/20
  Time: 12:31
--%>


<%@ page import="bitacora.Proyecto" %>

<g:if test="${!proyecto}">
    <elm:notFound elem="Proyecto" genero="o" />
</g:if>
<g:else>

    <g:if test="${proyecto?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Desripción
            </div>
            <div class="col-md-10">
                ${proyecto?.descripcion}
            </div>
        </div>
    </g:if>

    <g:if test="${proyecto?.responsable}">
        <div class="row">
            <div class="col-md-2 text-info">
                Responsable
            </div>
            <div class="col-md-10">
                ${proyecto?.responsable}
            </div>
        </div>
    </g:if>

    <g:if test="${proyecto?.telefono}">
        <div class="row">
            <div class="col-md-2 text-info">
                Teléfono
            </div>
            <div class="col-md-10">
                ${proyecto?.telefono}
            </div>
        </div>
    </g:if>

    <g:if test="${proyecto?.mail}">
        <div class="row">
            <div class="col-md-2 text-info">
                Mail
            </div>
            <div class="col-md-10">
                ${proyecto?.mail}
            </div>
        </div>
    </g:if>

</g:else>