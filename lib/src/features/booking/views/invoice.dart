import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orb/src/features/account/data/model/myBooking.dart';
import 'package:orb/src/features/booking/controller/bookingController.dart';
import 'package:orb/src/features/home/controller/search_controller.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../services/invoice_service.dart';

class CreatePdf {
  CreatePdf({this.myBookingModel});
  final MyBookingModel? myBookingModel;
  BookingController bookingController = Get.find<BookingController>();
  SearchController searchController = Get.find<SearchController>();

  Future<void> generateInvoice() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult result = await drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid, result);
    //Add invoice footer
    drawFooter(page, pageSize);
    //Save the PDF document
    final List<int> bytes = document.saveSync();
    //Dispose the document.
    document.dispose();
    //Save and launch the file.
    await saveAndLaunchFile(bytes, 'Invoice.pdf');
  }

  //Draws the invoice header
  Future<PdfLayoutResult> drawHeader(
      PdfPage page, Size pageSize, PdfGrid grid) async {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(3, 169, 244)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 20));
    //Draw string
    ByteData byteData = await rootBundle.load('assets/images/logo.jpg');
    Uint8List bytes = byteData.buffer.asUint8List();
    final PdfBitmap image = PdfBitmap(bytes);
    page.graphics.drawImage(image, Rect.fromLTWH(25, 40, 60, 60));
    page.graphics.drawString(
        '${myBookingModel != null ? myBookingModel!.hotelName : bookingController.hotel}',
        PdfStandardFont(PdfFontFamily.helvetica, 14),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(100, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 10);
    PdfTextElement(text: "Address", font: contentFont)
        .draw(page: page, bounds: Rect.fromLTWH(100, 60, 200, 20));
    // page.graphics.drawRectangle(
    //     bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
    //     brush: PdfSolidBrush(PdfColor(10, 133, 180)));

    // page.graphics.drawString(r'$' + getTotalAmount(grid).toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 18),
    //     bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
    //     brush: PdfBrushes.white,
    //     format: PdfStringFormat(
    //         alignment: PdfTextAlignment.center,
    //         lineAlignment: PdfVerticalAlignment.middle));

    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'Booking No: ${myBookingModel != null ? myBookingModel!.bookingNumber : bookingController.bookingId.value}\r\nDate: ${format.format(myBookingModel != null ? myBookingModel!.bookingDateFrom! : DateTime.now())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // ignore: leading_newlines_in_multiline_strings
    String address =
        '''Bill To:\r\n${myBookingModel != null ? "${myBookingModel!.firstname} ${myBookingModel!.lastname!}" : bookingController.fullName.value},\r\n${bookingController.email.value}\r\n${bookingController.phone.value}''';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;

    if (myBookingModel == null) {
      bookingController.feeDiscount.map((e) {
        page.graphics.drawString(
            e['title'],
            PdfStandardFont(PdfFontFamily.helvetica, 9,
                style: PdfFontStyle.bold),
            bounds: Rect.fromLTWH(
                quantityCellBounds!.left,
                result.bounds.bottom +
                    (10 * (bookingController.feeDiscount.indexOf(e) + 1)),
                quantityCellBounds!.width,
                quantityCellBounds!.height));
        page.graphics.drawString(
            e['value'],
            PdfStandardFont(PdfFontFamily.helvetica, 9,
                style: PdfFontStyle.bold),
            bounds: Rect.fromLTWH(
                totalPriceCellBounds!.left,
                result.bounds.bottom +
                    (10 * (bookingController.feeDiscount.indexOf(e) + 1)),
                totalPriceCellBounds!.width - 5,
                totalPriceCellBounds!.height),
            format: PdfStringFormat(alignment: PdfTextAlignment.right));
      }
          // detailsRow(
          //     e['title'],
          //     e['isPercentage'] ? "${e['percentOrAmount']} %" : null,
          //     "${e['value']}"),
          );
    } else {
      for (var e in bookingController.feeDiscountBooked) {
        print(e['value']);
        page.graphics.drawString(
            e['title'],
            PdfStandardFont(PdfFontFamily.helvetica, 9,
                style: PdfFontStyle.bold),
            bounds: Rect.fromLTWH(
                quantityCellBounds!.left,
                result.bounds.bottom +
                    (10 * (bookingController.feeDiscountBooked.indexOf(e) + 1)),
                quantityCellBounds!.width,
                quantityCellBounds!.height));
        page.graphics.drawString(
            double.parse(e['value'].toString()).toStringAsFixed(2),
            PdfStandardFont(PdfFontFamily.helvetica, 9,
                style: PdfFontStyle.bold),
            bounds: Rect.fromLTWH(
                totalPriceCellBounds!.left,
                result.bounds.bottom +
                    (10 * (bookingController.feeDiscountBooked.indexOf(e) + 1)),
                totalPriceCellBounds!.width - 5,
                totalPriceCellBounds!.height),
            format: PdfStringFormat(alignment: PdfTextAlignment.right));
      }
    }

    // //Draw grand total.
    page.graphics.drawString(
      'Grand Total',
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
          quantityCellBounds!.left,
          result.bounds.bottom +
              (10 *
                  (myBookingModel == null
                      ? bookingController.feeDiscount.length + 1
                      : bookingController.feeDiscountBooked.length + 1)),
          quantityCellBounds!.width,
          quantityCellBounds!.height),
    );
    page.graphics.drawString(
        double.parse((myBookingModel == null
                    ? bookingController.tempSubTotal
                    : bookingController.tempSubTotalBooked)
                .toString())
            .toStringAsFixed(2),
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom +
                (10 *
                    (myBookingModel == null
                        ? bookingController.feeDiscount.length + 1
                        : bookingController.feeDiscountBooked.length + 1)),
            totalPriceCellBounds!.width - 5,
            totalPriceCellBounds!.height),
        format: PdfStringFormat(alignment: PdfTextAlignment.right));
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 30),
        Offset(pageSize.width, pageSize.height - 30));

    const String footerContent =
        // ignore: leading_newlines_in_multiline_strings
        '''Powered by Aster Innovations''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 10),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 10, pageSize.height - 20, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'SN';
    headerRow.cells[1].value = 'Room Type';
    headerRow.cells[2].value = 'Quantity';
    headerRow.cells[3].value = 'Price';
    headerRow.cells[4].value = 'Total';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[3].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[4].stringFormat.alignment = PdfTextAlignment.center;
    //Add rows
    addProducts(
        "1",
        "${myBookingModel != null ? myBookingModel!.categoryName : bookingController.selectedRoom.value!.roomCategory!}\n(${myBookingModel != null ? myBookingModel!.noOfRooms : searchController.rooms.value} Room  x ${myBookingModel != null ? bookingController.night.value : bookingController.nights} nights)\n(${myBookingModel != null ? myBookingModel!.noOfAdults : searchController.adults.value} Adults ${myBookingModel != null ? myBookingModel!.childAges?.split(',').toList().length ?? 0 : searchController.childrens.value} Children)",
        myBookingModel != null
            ? myBookingModel!.price!.toDouble()
            : bookingController.selectedRoom.value!.minPrice!.toDouble(),
        myBookingModel != null
            ? bookingController.night.value
            : bookingController.nights,
        myBookingModel != null
            ? myBookingModel!.subTotal!
            : bookingController.subTotalValue,
        grid);
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        if (j > 1) {
          cell.stringFormat.alignment = PdfTextAlignment.right;
        }

        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addProducts(String productId, String productName, double price,
      int quantity, double total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = productId;
    row.cells[1].value = productName;
    row.cells[2].value = quantity.toString();
    row.cells[3].value = double.parse(price.toString()).toStringAsFixed(2);
    row.cells[4].value = double.parse(total.toString()).toStringAsFixed(2);
  }

  //Get the total amount.
  double getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value =
          grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return total;
  }
}
