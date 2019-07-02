<util:renderHTML html="${msg}"/>

<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}

th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}
</style>

<g:set var="clase" value="${'principal'}"/>

<div class="" style="width: 99.7%;height: ${msg == '' ? 600 : 585}px; overflow-y: auto;float: right; margin-top: -20px">
        <table class="table-bordered table-condensed table-hover" width="1060px">
                <g:each in="${actividades}" var="dato" status="z">

                    <tr id="${dato.id}" data-id="${dato.id}" class="${clase}">
                        <td class="codigo" style="width: 80px">
                            ${dato?.prioridad}
                        </td>

                        <td class="codigo" style="width: 270px">
                            ${dato?.padre}
                        </td>

                        <td class="asunto" style="width: 350px">
                            ${dato.descripcion}
                        </td>

                        <td class="prioridad" style="width: 100px">
                            ${dato.responsable}
                        </td>

                        <td class="prioridad" style="width: 50px">
                            ${dato.horas}
                        </td>
                        <td class="prioridad" style="width: 50px">
                            ${dato?.tiempo}
                        </td>
                        <td class="prioridad" style="width: 80px">
                            ${dato?.actvfcin?.format('yyyy-MM-dd')}
                        </td>
                        <td class="prioridad" style="width: 90px">
                            ${dato?.actvfcfn?.format('yyyy-MM-dd')}
                        </td>
                    </tr>
                </g:each>
        </table>
</div>


<script type="text/javascript">
    $(function () {
        $("tr").contextMenu({
            items  : createContextMenu,
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });

        $('.table').fixedHeaderTable({
            height : ${msg == '' ? 350 : 300}
        });
    });
</script>
