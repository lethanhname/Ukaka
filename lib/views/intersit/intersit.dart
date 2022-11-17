import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtubekaka/utils/navigation.dart';
import 'package:youtubekaka/views/intersit/client.dart';
import 'package:youtubekaka/views/intersit/my_server.dart';

class Intersit extends StatefulWidget {
  Intersit({Key? key}) : super(key: key);

  @override
  _IntersitState createState() => _IntersitState();
}

class _IntersitState extends State<Intersit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "TCP ",
                  style: GoogleFonts.nunito(
                      color: Colors.redAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  "| Chat",
                  style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 30,
                      fontWeight: FontWeight.w200),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 13),
                          blurRadius: 30)
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => navigate(context, Client()),
                    child: Text(
                      "Connect",
                      style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 13),
                          blurRadius: 30)
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => navigate(context, MyServer()),
                    child: Text(
                      "Start Server",
                      style: GoogleFonts.nunito(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}