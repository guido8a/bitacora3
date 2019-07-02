
<%@ page import="bitacora.Prioridad" %>

<g:if test="${!prioridadInstance}">
    <elm:notFound elem="Prioridad" genero="o" />
</g:if>
<g:else>

    <g:if test="${prioridadInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${prioridadInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>