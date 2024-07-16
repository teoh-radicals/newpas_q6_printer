import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:newpas_q6_printer/column_maker.dart';
import 'package:newpas_q6_printer/enums.dart';
import 'package:newpas_q6_printer/newpas_q6_printer.dart';
import 'package:newpas_q6_printer/text_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? initStatus = false;
  final _newpasQ6PrinterPlugin = NewpasQ6Printer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  await _newpasQ6PrinterPlugin
                      .bindPrinter()
                      .then((value) async {
                    initStatus = await _newpasQ6PrinterPlugin.initPrinter();

                    await _newpasQ6PrinterPlugin.printText(
                        "SIZE SM TESTING12345 ",
                        style: PrinterTextStyle(fontSize: FontSize.SM));
                    await _newpasQ6PrinterPlugin.printText(
                        "SIZE MD TESTING12345",
                        style: PrinterTextStyle(fontSize: FontSize.MD));
                    await _newpasQ6PrinterPlugin.printText(
                        "SIZE LG TESTING12345",
                        style: PrinterTextStyle(fontSize: FontSize.LG));
                    await _newpasQ6PrinterPlugin.printText(
                        "SIZE XL TESTING12345",
                        style: PrinterTextStyle(fontSize: FontSize.XL));
                    await _newpasQ6PrinterPlugin.resetFontSize();
                    await _newpasQ6PrinterPlugin.printText("ALIGN RIGHT",
                        style: PrinterTextStyle(align: PrintAlign.RIGHT));
                    await _newpasQ6PrinterPlugin.printText("ALIGN CENTER",
                        style: PrinterTextStyle(align: PrintAlign.CENTER));
                    await _newpasQ6PrinterPlugin.printText("ALIGN LEFT",
                        style: PrinterTextStyle(align: PrintAlign.LEFT));

                    await _newpasQ6PrinterPlugin.printRow([
                      ColumnMaker(
                        text: 'TEST',
                        width: 15,
                        align: PrintAlign.LEFT,
                      ),
                      ColumnMaker(
                          text: 'TEST 2', width: 14, align: PrintAlign.RIGHT),
                    ]);
                    await _newpasQ6PrinterPlugin.printRow([
                      ColumnMaker(
                        text: 'TEST',
                        width: 15,
                        align: PrintAlign.LEFT,
                      ),
                      ColumnMaker(
                          text: 'TEST 2', width: 14, align: PrintAlign.RIGHT),
                    ]);
                    await _newpasQ6PrinterPlugin.printRow([
                      ColumnMaker(
                        text: 'TEST',
                        width: 15,
                        align: PrintAlign.LEFT,
                      ),
                      ColumnMaker(
                          text: 'TEST 2', width: 14, align: PrintAlign.RIGHT),
                    ], end: true);

                    await _newpasQ6PrinterPlugin.line();

                    await _newpasQ6PrinterPlugin.lineWrap(10, height: 10);

                    await _newpasQ6PrinterPlugin.printBarcode('12345678',
                        width: 100);
                    await _newpasQ6PrinterPlugin.lineWrap(10, height: 5);
                    await _newpasQ6PrinterPlugin.printQRCode('12345678',
                        size: 10);
                    await _newpasQ6PrinterPlugin.lineWrap(10, height: 5);
                    await _newpasQ6PrinterPlugin.performPrint(feed: 100);
                  });

                  setState(() {});
                },
                child: const Text('Init printer')),
            Text('initstatus: $initStatus')
          ],
        ),
      ),
    );
  }
}
