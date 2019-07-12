<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/07/19
  Time: 12:36
--%>


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

<div class="" style="width: 99.7%;height: ${msg == '' ? 600 : 585}px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" width="100%">
        <g:each in="${lista.name}" var="registro">
            <tr>
                <td width="240px" style="font-size: 14px">
                    ${registro}
                </td>

                <td width="120px">
                    <g:if test="${registro.split("\\.")[1] == 'pdf'}">
                        PDF
                    </g:if>
                    <g:else>
                        <g:if test="${registro.split("\\.")[1] in ['jpeg', 'jpg', 'png']}">
                            Imagen
                        </g:if>
                        <g:else>
                            Otro
                        </g:else>
                    </g:else>
                </td>

                <td width="60px" class="text-info" style="text-align: center">
                    <a href="#" class="btn btn-info btn-sm" title="Descargar Archivo">
                        <i class="fa fa-download"></i>
                    </a>
                </td>
            </tr>
        </g:each>
    </table>
</div>


