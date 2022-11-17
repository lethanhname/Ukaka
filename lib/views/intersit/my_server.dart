import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtubekaka/core/viewmodel/server_vm.dart';

class MyServer extends StatefulWidget {
  MyServer({Key? key}) : super(key: key);

  @override
  _MyServerState createState() => _MyServerState();
}

class _MyServerState extends State<MyServer> {
  @override
  void initState() {
    context.read<ServerViewModel>().initState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ServerViewModel>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
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
                    fontWeight: FontWeight.w300),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  " Server",
                  style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
          TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Enter IP Address',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[300],
                ),
              ),
              controller: provider.ip,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ),
              keyboardAppearance: Brightness.light,
              autofocus: false),
          TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Enter Port',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[300],
                ),
              ),
              controller: provider.port,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ),
              keyboardAppearance: Brightness.light,
              autofocus: false),
          Text(
            provider?.errorMessage ?? '',
            style: GoogleFonts.nunito(
                color: Colors.red, fontSize: 11, fontWeight: FontWeight.w400),
          ),
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
                  onPressed: () {
                    provider.startServer(context);
                  },
                  child: Text(
                    "Energize",
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
