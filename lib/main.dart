import 'dart:convert';

import 'package:boobsrate/protos/tits.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(const BoobsRateApp());

class BoobsRateApp extends StatelessWidget {
  const BoobsRateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boobsrate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Boobsrate'),
        ),
        body: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Image img1 = Image.network("http://via.placeholder.com/350x150");
  Image img2 = Image.network("http://via.placeholder.com/350x150");
  String id1 = "";
  String id2 = "";
  int score1 = 0;
  int score2 = 0;

  WebSocketChannel chan = WebSocketChannel.connect(
    Uri.parse('ws://10.10.88.199:8081/ws'),
  );

  TitsServiceClient client = TitsServiceClient(
    ClientChannel(
      '10.10.88.199',
      port: 8080,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    ),
  );

  void _callVote(id) async {
    var response = await client.vote(
      VoteRequest(titsId: id),
      options: CallOptions(
        timeout: const Duration(seconds: 5),
      ),
    );
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    setState(() {
      img1 = Image.network(response.tits[0].imgUrl,
          height: height * 0.3, width: width * 0.9);
      id1 = response.tits[0].id;
      score1 = response.tits[0].rating.toInt();
      img2 = Image.network(response.tits[1].imgUrl,
          height: height * 0.3, width: width * 0.9);
      id2 = response.tits[1].id;
      score2 = response.tits[1].rating.toInt();
    });
  }

  void _callGrpcService() async {
    var response = await client.getTits(
      TitsRequest(),
      options: CallOptions(
        timeout: const Duration(seconds: 5),
      ),
    );
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    setState(() {
      img1 = Image.network(response.tits[0].imgUrl,
          height: height * 0.3, width: width * 0.9);
      id1 = response.tits[0].id;
      score1 = response.tits[0].rating.toInt();
      img2 = Image.network(response.tits[1].imgUrl,
          height: height * 0.3, width: width * 0.9);
      id2 = response.tits[1].id;
      score2 = response.tits[1].rating.toInt();
    });
  }

  void listenWS() async {
    chan.stream.listen(
      (event) {
        Map<String, dynamic> msg = jsonDecode(event.toString());
        if (msg["type"] == "new_rating") {
          String id = msg["message"]["tits_id"];
          int rating = msg["message"]["new_rating"];
          if (id == id1) {
            setState(() {
              score1 = rating;
            });
          } else if (id == id2) {
            setState(() {
              score2 = rating;
            });
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    chan.sink.close();
  }

  @override
  void initState() {
    super.initState();
    _callGrpcService();
    listenWS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                img1,
                Text(
                  "Rating: " + score1.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _callVote(id1);
                  },
                  child: const Text('UPPER'),
                ),
                ElevatedButton(
                    onPressed: _callGrpcService, child: const Text('REFRESH')),
                ElevatedButton(
                  onPressed: () {
                    _callVote(id2);
                  },
                  child: const Text('LOWER'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                img2,
                Text(
                  "Rating: " + score2.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
