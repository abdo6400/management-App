import 'package:baraneq/config/locale/app_localizations.dart';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path_provider;
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import '../../features/search/domain/entities/weekly_client.dart';

import 'app_images.dart';
import 'app_values.dart';

class CommonServices {
  static Future<void> generatePdf(
      {required WeeklyClient client,
      required BuildContext ctx,
      required double price}) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5);
    final font = await PdfGoogleFonts.cairoMedium();

    // Calculate summary totals
    double totalQuantityForAm = 0;

    double totalQuantityForPm = 0;

    double totalQuantityForDay = 0;

    for (var receipt in client.receipts) {
      totalQuantityForAm += receipt.totalQuantityForAm;

      totalQuantityForPm += receipt.totalQuantityForPm;

      totalQuantityForDay += receipt.totalQuantityForDay;
    }
    final img = await rootBundle.load(AppImages.appLogo);
    final imageBytes = img.buffer.asUint8List();
    pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.standard,
        build: (context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  height: 100,
                  child: image1,
                ),
                pw.Text(
                  '${AppStrings.weeklyReportfor.tr(ctx)} ${client.clientName}',
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(font: font, fontSize: 24),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  '${AppStrings.phoneNumber.tr(ctx)}: ${client.clientPhone}',
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(font: font, fontSize: 18),
                ),
                pw.SizedBox(height: 24),
                pw.Text(
                  '${AppStrings.receipts.tr(ctx)}:',
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FixedColumnWidth(100),
                    1: pw.FixedColumnWidth(100),
                    2: pw.FixedColumnWidth(100),
                    3: pw.FixedColumnWidth(100),
                    4: pw.FixedColumnWidth(100),
                    5: pw.FixedColumnWidth(100),
                  },
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            textDirection: pw.TextDirection.rtl,
                            '${AppStrings.totalQuantity.tr(ctx)}',
                            style: pw.TextStyle(
                                font: font, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            textDirection: pw.TextDirection.rtl,
                            ' ${AppStrings.am.tr(ctx)}',
                            style: pw.TextStyle(
                                font: font, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            textDirection: pw.TextDirection.rtl,
                            ' ${AppStrings.pm.tr(ctx)}',
                            style: pw.TextStyle(
                                font: font, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            textDirection: pw.TextDirection.rtl,
                            '${AppStrings.date.tr(ctx)}',
                            style: pw.TextStyle(
                                font: font, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            textDirection: pw.TextDirection.rtl,
                            '${AppStrings.day.tr(ctx)}',
                            style: pw.TextStyle(
                                font: font, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    ...client.receipts
                        .map((receipt) => pw.TableRow(
                              children: [
                                pw.Padding(
                                  padding: pw.EdgeInsets.all(8),
                                  child: pw.Text(
                                    textDirection: pw.TextDirection.rtl,
                                    receipt.totalQuantityForDay.toString(),
                                  ),
                                ),
                                pw.Padding(
                                  padding: pw.EdgeInsets.all(8),
                                  child: pw.Text(
                                    textDirection: pw.TextDirection.rtl,
                                    receipt.totalQuantityForAm.toString(),
                                  ),
                                ),
                                pw.Padding(
                                  padding: pw.EdgeInsets.all(8),
                                  child: pw.Text(
                                    textDirection: pw.TextDirection.rtl,
                                    receipt.totalQuantityForPm.toString(),
                                  ),
                                ),
                                pw.Padding(
                                  padding: pw.EdgeInsets.all(8),
                                  child: pw.Text(
                                    textDirection: pw.TextDirection.rtl,
                                    DateFormat('dd/MM/yyyy')
                                        .format(receipt.receiptDate),
                                  ),
                                ),
                                pw.Padding(
                                  padding: pw.EdgeInsets.all(8),
                                  child: pw.Text(
                                    textDirection: pw.TextDirection.rtl,
                                    getArabicWeekDayName(receipt.receiptDate),
                                    style: pw.TextStyle(font: font),
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                  ],
                ),
                // total for pm
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        totalQuantityForPm.toStringAsFixed(2),
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: font, fontSize: 15),
                      ),
                      pw.Text(
                        '${AppStrings.pm.tr(ctx)}',
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: font, fontSize: 15),
                      ),
                    ]),
                // total for am
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        totalQuantityForAm.toStringAsFixed(2),
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: font, fontSize: 15),
                      ),
                      pw.Text(
                        '${AppStrings.am.tr(ctx)}',
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: font, fontSize: 15),
                      ),
                    ]),
                // total quantity
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        totalQuantityForDay.toStringAsFixed(2),
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: font, fontSize: 15),
                      ),
                      pw.Text(
                        '${AppStrings.totalQuantity.tr(ctx)}',
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: font, fontSize: 15),
                      ),
                    ]),
                pw.Divider(),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        double.parse("${price * totalQuantityForDay}")
                            .toStringAsFixed(2),
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: font, fontSize: 15),
                      ),
                      pw.Text(
                        '${AppStrings.price.tr(ctx)}',
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: font, fontSize: 15),
                      ),
                    ]),
              ],
            ),
          );
        },
      ),
    );

    openPdf(await savePdf(await pdf.save()));
  }

  static String getArabicWeekDayName(DateTime date) {
    const arabicWeekDays = {
      'Monday': 'الاثنين',
      'Tuesday': 'الثلاثاء',
      'Wednesday': 'الأربعاء',
      'Thursday': 'الخميس',
      'Friday': 'الجمعة',
      'Saturday': 'السبت',
      'Sunday': 'الأحد'
    };

    // Get the English name of the week day
    String weekDay = DateFormat('EEEE').format(date);

    // Return the corresponding Arabic name
    return arabicWeekDays[weekDay] ?? weekDay;
  }

// Save PDF function
  static Future<String> savePdf(Uint8List pdfData) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/weekly_report.pdf';
    final file = File(filePath);
    await file.writeAsBytes(pdfData);
    return filePath;
  }

// Open PDF function
  static void openPdf(String filePath) {
    OpenFile.open(filePath);
  }

  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    //Get the storage folder location using path_provider package.
    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory =
          await path_provider.getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }
    final File file =
        File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    if (Platform.isAndroid || Platform.isIOS) {
      //Launch the file (used open_file package)
      await open_file.OpenFile.open('$path/$fileName');
    } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\$fileName'],
          runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/$fileName'],
          runInShell: true);
    }
  }
}
