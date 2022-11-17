import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtubekaka/core/model/tcpData.dart';
import 'package:youtubekaka/core/viewmodel/server_vm.dart';
import 'package:youtubekaka/widgets/qrDialog.dart';

class HomePage extends StatefulWidget {
  final TCPData tcpData;
  final bool isHost;

  const HomePage({Key? key, required this.tcpData, this.isHost = false})
      : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ServerViewModel serverProvider;

  @override
  void dispose() {
    if (widget.isHost) serverProvider.server.close();
    serverProvider.closeSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    serverProvider = context.watch<ServerViewModel>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme:
            IconThemeData(color: widget.isHost ? Colors.white : Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "TCP ",
              style: GoogleFonts.nunito(
                  color: widget.isHost ? Colors.white : Colors.redAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
            Text(
              "| Chat",
              style: GoogleFonts.lato(
                  color: widget.isHost ? Colors.white : Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
        backgroundColor: widget.isHost ? Colors.redAccent : Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            color: Colors.grey[300],
            onPressed: () {
              showQRDialog(context, widget.tcpData);
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 80,
            child: ListView(
              reverse: true,
              children: <Widget>[
                for (var messageItem in serverProvider.messageList)
                  Text(messageItem.message),
              ],
            ),
          ),
          Flexible(flex: 10, child: TextField(controller: serverProvider.msg)),
          Flexible(
            flex: 10,
            child: ElevatedButton(
              onPressed: () {
                if (serverProvider.msg.text.isNotEmpty) {
                  serverProvider.sendMessage(
                    context,
                    widget.tcpData,
                    isHost: widget.isHost,
                  );
                }
              },
              child: Text('Send'),
            ),
          )
        ],
      ),
    );
  }
}
