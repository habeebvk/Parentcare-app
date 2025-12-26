import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:parent_care/model/cab_booking.dart';

class InvoiceGenerator {
  static Future<void> generateAndOpenInvoice(CabBookingModel cab) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "CAB BOOKING INVOICE",
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Divider(),

                pw.SizedBox(height: 20),
                _row("Name", cab.name),
                _row("Pickup", cab.pickup),
                _row("Drop", cab.drop),
                _row("Time", "${cab.time.hour}:${cab.time.minute}"),
                _row("Status", cab.status),

                pw.SizedBox(height: 30),
                pw.Text(
                  "Amount Paid: ₹500",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.Spacer(),

                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    "Thank you for choosing our service!",
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/invoice_${cab.id}.pdf");

    await file.writeAsBytes(await pdf.save());

    // Open the PDF
    await Printing.layoutPdf(onLayout: (_) => pdf.save());
  }

  static pw.Widget _row(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 2,
            child: pw.Text(
              "$title:",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Text(value),
          ),
        ],
      ),
    );
  }
}
