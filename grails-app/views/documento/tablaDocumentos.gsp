<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 23/07/19
  Time: 12:10
--%>

<util:renderHTML html="${msg}"/>
<asset:stylesheet src="/apli/lzm.context-0.5.css"/>
<asset:javascript src="/apli/lzm.context-0.5.js"/>


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
        <g:each in="${b}" var="dato" status="z">

            <tr id="${dato.key.id}" data-id="${dato.key.id}" class="${clase}">
                <td width="120px">
                    ${dato?.key?.tema}
                </td>
                <td width="500px">
                    ${dato?.key?.problema}
                </td>
                <td width="100px"  style="font-size: 12px; color: #fdfbff;text-align: center; background-color: ${dato?.value[0] == 0 ? '#a32713' : '#294ea3'}">
                    ${dato?.value[0]}
                </td>
                <td width="100px"  style="font-size: 12px; color: #fdfbff; text-align: center; background-color: ${dato?.value[1] == 0 ? '#a32713' : '#294ea3'}">
                    ${dato?.value[1]}
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
