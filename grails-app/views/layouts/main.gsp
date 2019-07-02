<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Bitácora"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

    <g:layoutHead/>

    <asset:stylesheet src="/apli/bootstrap.css"/>
    <asset:stylesheet src="/bootstrap-grid.css"/>
    <asset:stylesheet src="/bootstrap-reboot.css"/>
    <asset:stylesheet src="/fontawesome/font-awesome.min.css"/>
    <asset:stylesheet src="/jquery/jquery-ui-1.10.3.custom.min.css"/>
    <asset:stylesheet src="/apli/lzm.context-0.5.css"/>

%{--    <asset:javascript src="/jquery-3.3.1.min.js"/>--}%
    <asset:javascript src="/jquery/jquery-2.2.4.js"/>
    <asset:javascript src="/apli/bootstrap.min.js"/>
    <asset:javascript src="/jquery/jquery-ui-1.10.3.custom.min.js"/>
    <asset:javascript src="/apli/funciones.js"/>
    <asset:javascript src="/apli/functions.js"/>
    <asset:javascript src="/apli/loader.js"/>
    <asset:javascript src="/apli/bootbox.js"/>
    <asset:javascript src="/apli/bootbox.js"/>
    <asset:javascript src="/apli/lzm.context-0.5.js"/>
    <asset:javascript src="/jquery/jquery.validate.min.js"/>
    <asset:javascript src="/jquery/jquery-ui-1.10.3.custom.min.js"/>
    <asset:javascript src="/jquery/messages_es.js"/>

</head>

<body>

%{--<g:layoutBody/>--}%



<div id="modalTabelGray"></div>

%{--<div id="modalDiv" class="ui-corner-all">--}%
%{--    <div class="loading-title">Procesando</div>--}%
%{--    <img src="${resource(dir: 'images', file: 'spinner32.gif')}">--}%
%{--    <asset:image src="apli/spinner32.gif" style="padding: 40px;"/>--}%

%{--    <div class="loading-footer">Espere por favor</div>--}%
%{--</div>--}%

<mn:menu title="${g.layoutTitle(default: 'Bitácora')}"/>

<div class="container" style="min-width: 1000px !important; margin-top: 80px; overflow-y: hidden">
    <g:layoutBody/>
</div>

%{--<div id="spinner" class="spinner" style="display:none;">--}%
%{--    <g:message code="spinner.alt" default="Loading&hellip;"/>--}%
%{--</div>--}%

<asset:javascript src="application.js"/>

</body>
</html>
