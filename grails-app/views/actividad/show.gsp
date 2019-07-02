
<%@ page import="bitacora.Actividad" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'actividad.label', default: 'Actividad')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-actividad" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-actividad" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list actividad">
			
				<g:if test="${actividadInstance?.padre}">
				<li class="fieldcontain">
					<span id="padre-label" class="property-label"><g:message code="actividad.padre.label" default="Padre" /></span>
					
						<span class="property-value" aria-labelledby="padre-label"><g:link controller="actividad" action="show" id="${actividadInstance?.padre?.id}">${actividadInstance?.padre?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.descripcion}">
				<li class="fieldcontain">
					<span id="descripcion-label" class="property-label"><g:message code="actividad.descripcion.label" default="Descripcion" /></span>
					
						<span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${actividadInstance}" field="descripcion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.fechaInicio}">
				<li class="fieldcontain">
					<span id="fechaInicio-label" class="property-label"><g:message code="actividad.fechaInicio.label" default="Fecha Inicio" /></span>
					
						<span class="property-value" aria-labelledby="fechaInicio-label"><g:formatDate date="${actividadInstance?.fechaInicio}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.fechaFin}">
				<li class="fieldcontain">
					<span id="fechaFin-label" class="property-label"><g:message code="actividad.fechaFin.label" default="Fecha Fin" /></span>
					
						<span class="property-value" aria-labelledby="fechaFin-label"><g:formatDate date="${actividadInstance?.fechaFin}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.horas}">
				<li class="fieldcontain">
					<span id="horas-label" class="property-label"><g:message code="actividad.horas.label" default="Horas" /></span>
					
						<span class="property-value" aria-labelledby="horas-label"><g:fieldValue bean="${actividadInstance}" field="horas"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.tiempo}">
				<li class="fieldcontain">
					<span id="tiempo-label" class="property-label"><g:message code="actividad.tiempo.label" default="Tiempo" /></span>
					
						<span class="property-value" aria-labelledby="tiempo-label"><g:fieldValue bean="${actividadInstance}" field="tiempo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.ingresa}">
				<li class="fieldcontain">
					<span id="ingresa-label" class="property-label"><g:message code="actividad.ingresa.label" default="Ingresa" /></span>
					
						<span class="property-value" aria-labelledby="ingresa-label"><g:link controller="persona" action="show" id="${actividadInstance?.ingresa?.id}">${actividadInstance?.ingresa?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.responsable}">
				<li class="fieldcontain">
					<span id="responsable-label" class="property-label"><g:message code="actividad.responsable.label" default="Responsable" /></span>
					
						<span class="property-value" aria-labelledby="responsable-label"><g:link controller="persona" action="show" id="${actividadInstance?.responsable?.id}">${actividadInstance?.responsable?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.prioridad}">
				<li class="fieldcontain">
					<span id="prioridad-label" class="property-label"><g:message code="actividad.prioridad.label" default="Prioridad" /></span>
					
						<span class="property-value" aria-labelledby="prioridad-label"><g:link controller="prioridad" action="show" id="${actividadInstance?.prioridad?.id}">${actividadInstance?.prioridad?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.como}">
				<li class="fieldcontain">
					<span id="como-label" class="property-label"><g:message code="actividad.como.label" default="Como" /></span>
					
						<span class="property-value" aria-labelledby="como-label"><g:fieldValue bean="${actividadInstance}" field="como"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.avance}">
				<li class="fieldcontain">
					<span id="avance-label" class="property-label"><g:message code="actividad.avance.label" default="Avance" /></span>
					
						<span class="property-value" aria-labelledby="avance-label"><g:fieldValue bean="${actividadInstance}" field="avance"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.observaciones}">
				<li class="fieldcontain">
					<span id="observaciones-label" class="property-label"><g:message code="actividad.observaciones.label" default="Observaciones" /></span>
					
						<span class="property-value" aria-labelledby="observaciones-label"><g:fieldValue bean="${actividadInstance}" field="observaciones"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${actividadInstance?.fechaRegistro}">
				<li class="fieldcontain">
					<span id="fechaRegistro-label" class="property-label"><g:message code="actividad.fechaRegistro.label" default="Fecha Registro" /></span>
					
						<span class="property-value" aria-labelledby="fechaRegistro-label"><g:formatDate date="${actividadInstance?.fechaRegistro}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:actividadInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${actividadInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
