import 'dart:io';
import 'dart:convert' show json, utf8;

import 'package:flutter/material.dart';
import 'package:r_get_ip/r_get_ip.dart';
import 'package:youtubekaka/core/model/message.dart';
import 'package:youtubekaka/core/model/tcpData.dart';
import 'package:youtubekaka/utils/navigation.dart';
import 'package:youtubekaka/views/home.dart';
import 'package:youtubekaka/views/youtube_search.dart';
import 'package:youtubekaka/widgets/qrDialog.dart';

class ServerViewModel extends ChangeNotifier {
  final List<Message> _messageList = [];
  List<Message> get messageList => _messageList;
  String errorMessage = '';

  late ServerSocket _server;
  ServerSocket get server => _server;

  late Socket _socket;
  Socket get socket => _socket;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  final TextEditingController ip = TextEditingController();
  final TextEditingController port = TextEditingController();
  final TextEditingController msg = TextEditingController();

  set server(ServerSocket val) {
    _server = val;
    notifyListeners();
  }

  set socket(Socket val) {
    _socket = val;
    notifyListeners();
  }

  void initState() async {
    var internalIP = await RGetIp.internalIP;
    ip.text = internalIP!;
    port.text = "4000";
    errorMessage = '';
  }

  getTCPData() {
    return TCPData(ip.text, int.parse(port.text));
  }

  void startServer(context) async {
    if (ip.text.isEmpty) {
      errorMessage = "IP Address cant be empty!";
      notifyListeners();
    } else if (port.text.isEmpty) {
      errorMessage = "Port cant be empty!";
      notifyListeners();
    } else {
      errorMessage = "";
      notifyListeners();
      try {
        _server = await ServerSocket.bind(ip.text, int.parse(port.text),
            shared: true);
        notifyListeners();

        _server.listen((Socket _) {
          _socket = _;
          _.listen((List<int> data) {
            try {
              String result = String.fromCharCodes(data);

                var message = Message.fromJson(json.decode(result));
                _messageList.insert(
                    0,
                    Message(
                        message.message));
                notifyListeners();
              _.add(data);
            } catch (e) {
              print(e.toString());
            }
            notifyListeners();
          });
        });

        print('Started: ${server.address.toString()}');
        connectToServer(context);
        navigateReplace(
          context,
          YouTubeSearch(),
        );
      } catch (e) {
        print(e.toString());
        showErrorDialog(context, e.toString());
      }
    }
  }

  connectToServer(context, {bool isHost = true}) async {
    if (ip.text.isEmpty) {
      errorMessage = "IP Address cant be empty!";
      notifyListeners();
    } else if (port.text.isEmpty) {
      errorMessage = "Port cant be empty!";
      notifyListeners();
    } else {
      try {
        _isLoading = true;
        notifyListeners();
        _socket = await Socket.connect(ip.text, int.parse(port.text))
            .timeout(const Duration(seconds: 10), onTimeout: () {
          throw "TimeOUt";
        });
        notifyListeners();
        // listen to the received data event stream
        _socket.listen((List<int> data) {
          try {
            String result = new String.fromCharCodes(data);

              var message = Message.fromJson(json.decode(result));
              _messageList.insert(
                  0,
                  Message(
                      message.message));
              notifyListeners();
          } catch (e) {
            print(e.toString());
          }
        });
        print('connected');
        if (!isHost){
          navigateReplace(
            context,
            HomePage(tcpData: TCPData(ip.text, int.parse(port.text)))
          );
        }


        _isLoading = false;
        notifyListeners();
      } catch (e) {
        _isLoading = false;
        notifyListeners();
        showErrorDialog(context, e.toString());
        print(e.toString());
      }
    }
  }

  closeSocket() async {
    await _socket.close();
  }

  void sendMessage(context, TCPData tcpData, {bool? isHost}) {
    /* _messageList.insert(
        0, new Message(message: msg.text, user: 0, userID: null)); */

    var message = utf8.encode(json.encode(
        Message(msg.text).toJson()));

    if (isHost != null && isHost) {
      _messageList.insert(
        0,
        Message(msg.text),
      );
      notifyListeners();
    }

    try {
      _socket.add(message);

      msg.clear();
    } catch (e) {
      showErrorDialog(context, e.toString());
      print(e.toString());
    }
    notifyListeners();
  }

  @override
  void dispose() {
    closeSocket();
    _server.close();
    super.dispose();
  }
  //
  // void scan(context) async {
  //   errorMessage = "";
  //   try {
  //     var result = await BarcodeScanner.scan();
  //     notifyListeners();
  //     if (result != null) {
  //       var tcpData = TCPData.fromJson(json.decode(result.rawContent));
  //
  //       ip.text = tcpData.ip;
  //       port.text = tcpData.port.toString();
  //       notifyListeners();
  //
  //       connectToServer(context, isHost: false);
  //     }
  //   } on PlatformException catch (e) {
  //     var result = ScanResult(
  //       type: ResultType.Error,
  //       format: BarcodeFormat.unknown,
  //     );
  //
  //     if (e.code == BarcodeScanner.cameraAccessDenied) {
  //       result.rawContent = 'The user did not grant the camera permission!';
  //     } else {
  //       result.rawContent = 'Unknown error: $e';
  //     }
  //     showErrorDialog(context, error: result.rawContent);
  //   }
  // }
}