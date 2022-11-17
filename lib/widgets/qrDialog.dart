import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:youtubekaka/core/model/tcpData.dart';

showQRDialog(BuildContext context, TCPData tcpData) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: FractionallySizedBox(
          heightFactor: 0.5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Scan to Connect",
                  style: GoogleFonts.nunito(
                      color: Colors.grey[500],
                      fontSize: 20,
                      fontWeight: FontWeight.w100),
                ),
                const SizedBox(height: 40),
                QrImage(
                  data: json.encode(TCPData(
                    tcpData.ip,
                    tcpData.port,
                  ).toJson()),
                  padding: EdgeInsets.zero,
                  version: QrVersions.auto,
                  foregroundColor: Colors.redAccent,
                  size: 180.0,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
      );
    });

showErrorDialog(BuildContext context, String error) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: FractionallySizedBox(
          heightFactor: 0.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Error",
                    style: GoogleFonts.nunito(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      error ?? ' ',
                      style: GoogleFonts.nunito(
                          color: Colors.grey[500],
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
        ),
      );
    });
