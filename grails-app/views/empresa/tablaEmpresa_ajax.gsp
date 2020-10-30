<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 30/10/20
  Time: 11:12
--%>

%{--<util:renderHTML html="${msg}"/>--}%

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

<div class="" style="width: 99.7%;height: 390px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" width="100%">
        <g:each in="${empresas}" var="empresa" status="z">
            <tr id="${empresa.id}" data-id="${empresa.id}">
                <td style="width: 40%">
                    ${empresa?.nombre}
                </td>
                <td style="width: 30%">
                    ${empresa?.direccion}
                </td>
                <td style="width: 10%">
                    ${empresa?.telefono}
                </td>
                <td style="width: 10%">
                    ${empresa?.mail}
                </td>
                <td style="width: 10%">
                    ${empresa?.ruc}
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
    });
</script>