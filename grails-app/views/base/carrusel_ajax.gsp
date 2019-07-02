<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 29/06/16
  Time: 03:37 PM
--%>
<div class="col-md-2"></div>
<div id="carousel-example-generic" class="carousel slide col-md-8" data-ride="carousel">
    <ol class="carousel-indicators">

        <g:each in="${listaImagenes}" var="lis" status="j">
            <g:if test="${j == 0}">
                <li data-target="#carousel-example-generic" data-slide-to="${j}" class="active"></li>
            </g:if>
            <g:else>
                <li data-target="#carousel-example-generic" data-slide-to="${j}"></li>
            </g:else>
        </g:each>


    %{--<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>--}%
    %{--<li data-target="#carousel-example-generic" data-slide-to="1"></li>--}%
    %{--<li data-target="#carousel-example-generic" data-slide-to="2"></li>--}%
    </ol>
    <div class="carousel-inner" role="listbox">


        <g:each in="${listaImagenes}" var="imagen" status="k">
            <g:if test="${k == 0}">
                <div class="item active">
                    <a href="#" class="btn btn-danger btnEliminarImagen btn-xs" title="Eliminar imagen" data-id="${imagen?.id}" style="margin-left: 50%">
                        <i class="fa fa-close"></i>
                    </a>
                    <img src="${resource(dir: 'imagenes', file: imagen?.ruta)}" style="padding: 10px; height: 400px"/>
                    <span>
                        ${imagen?.descripcion}
                    </span>
                </div>
            </g:if>
            <g:else>
                <div class="item">
                    <a href="#" class="btn btn-danger btnEliminarImagen btn-xs" title="Eliminar imagen" data-id="${imagen?.id}" style="margin-left: 50%">
                        <i class="fa fa-close"></i>
                    </a>
                    <img src="${resource(dir: 'imagenes', file: imagen?.ruta)}" style="padding: 10px; height: 400px"/>
                    <span>
                        ${imagen?.descripcion}
                    </span>
                </div>
            </g:else>

        </g:each>


        %{--<div class="item active">--}%
            %{--<img src="${resource(dir: 'images', file: 'conocimiento.png')}" style="padding: 10px; height: 330px"/>--}%
            %{--<span>--}%
                %{--Explicaicón de la imagen 1--}%
            %{--</span>--}%
        %{--</div>--}%

        %{--<div class="item">--}%
            %{--<img src="${resource(dir: 'images', file: 'bitacora.png')}" style="padding: 10px; height: 330px"/>--}%
            %{--<span>--}%
                %{--Explicaicón de la imagen 2 .........--}%
            %{--</span>--}%
        %{--</div>--}%

        %{--<div class="item">--}%
            %{--<img src="${resource(dir: 'images', file: 'agenda.png')}" style="padding: 10px; height: 330px"/>--}%
        %{--</div>--}%
    </div>

    <!-- Controls -->
    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>