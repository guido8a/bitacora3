package reportes

import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.Font
import org.apache.poi.ss.usermodel.IndexedColors
import org.apache.poi.ss.util.CellRangeAddress
import org.apache.poi.xssf.usermodel.*
import seguridad.Departamento
import seguridad.Persona
import seguridad.Sesn

class ReportesController {
    def dbConnectionService

    def reporteUsuariosPerfiles () {

        def unidades = Departamento.list([sort: 'nombre'])
        def usuarios = Persona.findAllByDepartamentoInList(unidades)
        def sesiones = Sesn.findAllByUsuarioInList(usuarios, [sort: "usuario.departamento.nombre", order: "asc"])

        def iniRow = 0
        def iniCol = 1

        def curRow = iniRow
        def curCol = iniCol

        try {
            XSSFWorkbook wb = new XSSFWorkbook()
            XSSFSheet sheet = wb.createSheet("usuarios")

            def estilos = getEstilos(wb)
            CellStyle styleHeader = estilos.styleHeader
            CellStyle styleTabla = estilos.styleTabla
            CellStyle styleFooter = estilos.styleFooter
            CellStyle styleFooterCenter = estilos.styleFooterCenter
            CellStyle styleNumber = estilos.styleNumber
            CellStyle styleDate = estilos.styleDate

            def titulo = "Reporte de Usuarios y Perfiles"
            def subtitulo = ""

            curRow = setTitulos(sheet, estilos, iniRow, iniCol, titulo, subtitulo)
            XSSFRow rowHeader = sheet.createRow((short) curRow)
            curRow++

            XSSFCell cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("N°")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 1000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("NOMBRE")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 6000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("USUARIO")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 2000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("UNIDAD")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 10000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("CARGO")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 6000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("PERFIL")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 5000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("ACTIVO")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 3000)
            curCol++


            def totalCols = curCol

            joinTitulos(sheet, iniRow, iniCol, totalCols, false)

            def totalPriorizado = 0
            def total1 = 0
            def total2 = 0
            def total3 = 0
            def total4 = 0
            def ordinal = 1

            sesiones.each { d ->
                curCol = iniCol
                XSSFRow tableRow = sheet.createRow((short) curRow)
                XSSFCell cellTabla = tableRow.createCell((short) curCol)

                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(ordinal++)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(d?.usuario?.nombre + " " + d?.usuario?.apellido)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(d?.usuario?.login)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(d?.usuario?.departamento?.nombre)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(d?.usuario?.cargo)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                cellTabla = tableRow.createCell((short) curCol)
                cellTabla.setCellValue(d?.perfil?.nombre)
                cellTabla.setCellStyle(styleTabla)
                curCol++
                if(d?.usuario?.estaActivo == 1){
                    cellTabla = tableRow.createCell((short) curCol)
                    cellTabla.setCellValue("SI")
                    cellTabla.setCellStyle(styleTabla)
                    curCol++
                }else{
                    cellTabla = tableRow.createCell((short) curCol)
                    cellTabla.setCellValue("NO")
                    cellTabla.setCellStyle(styleTabla)
                    curCol++
                }
                curRow++
            }

            sheet.addMergedRegion(new CellRangeAddress(
                    curRow, //first row (0-based)
                    curRow, //last row  (0-based)
                    iniCol, //first column (0-based)
                    iniCol + 3 //last column  (0-based)
            ))

            def output = response.getOutputStream()
            def header = "attachment; filename=" + "reporte_usuarios_perfiles.xlsx"
            response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
            response.setHeader("Content-Disposition", header)
            wb.write(output)
            output.flush()

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }


    def setTitulos(XSSFSheet sheet, estilos, int iniRow, int iniCol, String titulo, String subtitulo) {
        CellStyle styleYachay = estilos.styleYachay
        CellStyle styleTitulo = estilos.styleTitulo
        CellStyle styleSubtitulo = estilos.styleSubtitulo
        CellStyle styleFecha = estilos.styleFecha

        def curRow = iniRow

        XSSFRow rowYachay = sheet.createRow((short) curRow)
        XSSFCell cellYachay = rowYachay.createCell((short) iniCol)
        cellYachay.setCellValue("BITÁCORA")
        cellYachay.setCellStyle(styleYachay)
        curRow++

        XSSFRow rowTitulo = sheet.createRow((short) curRow)
        XSSFCell cellTitulo = rowTitulo.createCell((short) iniCol)
        cellTitulo.setCellValue(titulo)
        cellTitulo.setCellStyle(styleTitulo)
        curRow++

        if (subtitulo && subtitulo != "") {
            XSSFRow rowSubtitulo = sheet.createRow((short) curRow)
            XSSFCell cellSubtitulo = rowSubtitulo.createCell((short) iniCol + 3)
            cellSubtitulo.setCellValue(subtitulo)
            cellSubtitulo.setCellStyle(styleTitulo)
            curRow++
        }

        XSSFRow rowFecha = sheet.createRow((short) curRow)
        XSSFCell cellFecha = rowFecha.createCell((short) iniCol + 1)
        cellFecha.setCellValue("Fecha del reporte: " + new Date().format("dd-MM-yyyy HH:mm"))
        cellFecha.setCellStyle(styleFecha)
        curRow++

        return curRow
    }

/*
    public static joinTitulos(Sheet sheet, int iniRow, int iniCol, int totalCols) {
        joinTitulos(sheet, iniRow, iniCol, totalCols, true)
    }
*/

//    public static joinTitulos(Sheet sheet, int iniRow, int iniCol, int totalCols, boolean subtitulo) {
    def joinTitulos(XSSFSheet sheet, int iniRow, int iniCol, int totalCols, boolean subtitulo) {
        sheet.addMergedRegion(new CellRangeAddress(
                iniRow, //first row (0-based)
                iniRow, //last row  (0-based)
                iniCol, //first column (0-based)
                totalCols  //last column  (0-based)
        ))
        sheet.addMergedRegion(new CellRangeAddress(
                iniRow + 1, //first row (0-based)
                iniRow + 1, //last row  (0-based)
                iniCol, //first column (0-based)
                totalCols   //last column  (0-based)
        ))
        if (subtitulo) {
            sheet.addMergedRegion(new CellRangeAddress(
                    iniRow + 2, //first row (0-based)
                    iniRow + 2, //last row  (0-based)
                    iniCol, //first column (0-based)
                    totalCols   //last column  (0-based)
            ))
            sheet.addMergedRegion(new CellRangeAddress(
                    iniRow + 3, //first row (0-based)
                    iniRow + 3, //last row  (0-based)
                    iniCol + 1, //first column (0-based)
                    iniCol + 2   //last column  (0-based)
            ))
        } else {
            sheet.addMergedRegion(new CellRangeAddress(
                    iniRow + 2, //first row (0-based)
                    iniRow + 2, //last row  (0-based)
                    iniCol + 1, //first column (0-based)
                    iniCol + 2   //last column  (0-based)
            ))
        }
    }


    def getEstilos(XSSFWorkbook wb) {

        XSSFCreationHelper createHelper = wb.getCreationHelper();
        def numberFormat = createHelper.createDataFormat().getFormat('#,##0.00')
        def dateFormat = createHelper.createDataFormat().getFormat("dd-MM-yyyy")

        Font fontYachay = wb.createFont()
        fontYachay.setFontHeightInPoints((short) 12)
        fontYachay.setBold(true)

        Font fontTitulo = wb.createFont()
        fontTitulo.setFontHeightInPoints((short) 12)
        fontTitulo.setBold(true)

        Font fontSubtitulo = wb.createFont()
        fontSubtitulo.setFontHeightInPoints((short) 12)
        fontSubtitulo.setBold(true)

        Font fontHeader = wb.createFont()
        fontHeader.setFontHeightInPoints((short) 9)
        fontHeader.setColor(new XSSFColor(new java.awt.Color(255, 255, 255)))
        fontHeader.setBold(true)

        Font fontTabla = wb.createFont()
        fontTabla.setFontHeightInPoints((short) 9)

        Font fontSubtotal = wb.createFont()
        fontSubtotal.setFontHeightInPoints((short) 9)
        fontSubtotal.setBold(true)

        Font fontFecha = wb.createFont()
        fontFecha.setFontHeightInPoints((short) 9)

        Font fontFooter = wb.createFont()
        fontFooter.setFontHeightInPoints((short) 9)
        fontFooter.setBold(true)

        CellStyle styleYachay = wb.createCellStyle()
        styleYachay.setFont(fontYachay)
        styleYachay.setAlignment(CellStyle.ALIGN_CENTER)
        styleYachay.setVerticalAlignment(CellStyle.VERTICAL_CENTER)

        CellStyle styleTitulo = wb.createCellStyle()
        styleTitulo.setFont(fontTitulo)
        styleTitulo.setAlignment(CellStyle.ALIGN_CENTER)
        styleTitulo.setVerticalAlignment(CellStyle.VERTICAL_CENTER)

        CellStyle styleSubtitulo = wb.createCellStyle()
        styleSubtitulo.setFont(fontSubtitulo)
        styleSubtitulo.setAlignment(CellStyle.ALIGN_CENTER)
        styleSubtitulo.setVerticalAlignment(CellStyle.VERTICAL_CENTER)

        CellStyle styleHeader = wb.createCellStyle()
        styleHeader.setFont(fontHeader)
        styleHeader.setAlignment(CellStyle.ALIGN_CENTER)
        styleHeader.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
        styleHeader.setFillForegroundColor(new XSSFColor(new java.awt.Color(50, 96, 144)));
        styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND)
        styleHeader.setWrapText(true);
        styleHeader.setBorderBottom(CellStyle.BORDER_THIN);
        styleHeader.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
        styleHeader.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        styleHeader.setBorderRight(CellStyle.BORDER_THIN);
        styleHeader.setRightBorderColor(IndexedColors.BLACK.getIndex());
        styleHeader.setBorderTop(CellStyle.BORDER_THIN);
        styleHeader.setTopBorderColor(IndexedColors.BLACK.getIndex());

        CellStyle styleFecha = wb.createCellStyle()
        styleFecha.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
        styleFecha.setFont(fontFecha)
        styleFecha.setWrapText(true);

        CellStyle styleTabla = wb.createCellStyle()
        styleTabla.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
        styleTabla.setFont(fontTabla)
        styleTabla.setWrapText(true);
        styleTabla.setBorderBottom(CellStyle.BORDER_THIN);
        styleTabla.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styleTabla.setBorderLeft(CellStyle.BORDER_THIN);
        styleTabla.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        styleTabla.setBorderRight(CellStyle.BORDER_THIN);
        styleTabla.setRightBorderColor(IndexedColors.BLACK.getIndex());
        styleTabla.setBorderTop(CellStyle.BORDER_THIN);
        styleTabla.setTopBorderColor(IndexedColors.BLACK.getIndex());

        CellStyle styleDate = styleTabla.clone()
        styleDate.setDataFormat(dateFormat);

        CellStyle styleNumber = styleTabla.clone()
        styleNumber.setDataFormat(numberFormat);

        CellStyle styleSubtotal = styleTabla.clone()
        styleSubtotal.setFont(fontSubtotal)
        styleSubtotal.setAlignment(CellStyle.ALIGN_CENTER)
        styleSubtotal.setFillForegroundColor(new XSSFColor(new java.awt.Color(111, 169, 237)));
        styleSubtotal.setFillPattern(CellStyle.SOLID_FOREGROUND)

        CellStyle styleSubtotalNumber = styleSubtotal.clone()
        styleSubtotalNumber.setAlignment(CellStyle.ALIGN_RIGHT)
        styleSubtotalNumber.setDataFormat(numberFormat);

        CellStyle styleFooterText = styleTabla.clone()
        styleFooterText.setFont(fontFooter)
        styleFooterText.setFillForegroundColor(new XSSFColor(new java.awt.Color(200, 200, 200)));
        styleFooterText.setFillPattern(CellStyle.SOLID_FOREGROUND)

        CellStyle styleFooterCenter = styleFooterText.clone()
        styleFooterCenter.setAlignment(CellStyle.ALIGN_RIGHT)

        CellStyle styleFooter = styleFooterText.clone()
        styleFooter.setDataFormat(numberFormat);

        return [styleYachay    : styleYachay, styleTitulo: styleTitulo, styleSubtitulo: styleSubtitulo, styleHeader: styleHeader,
                styleNumber    : styleNumber, styleFooter: styleFooter, styleDate: styleDate,
                styleSubtotal  : styleSubtotal, styleSubtotalNumber: styleSubtotalNumber, styleTabla: styleTabla,
                styleFooterText: styleFooterText, styleFooterCenter: styleFooterCenter, styleFecha: styleFecha]
    }


}
