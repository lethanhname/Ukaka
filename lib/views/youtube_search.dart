import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtubekaka/utils/navigation.dart';
import 'package:youtubekaka/views/my_player.dart';

class YouTubeSearch extends StatefulWidget {
  const YouTubeSearch({super.key});

  @override
  _YouTubeSearchState createState() => _YouTubeSearchState();
}

class _YouTubeSearchState extends State<YouTubeSearch> {
  bool typing = false;
  static String key = "AIzaSyCoU4G5XqQN_fG5OioDQJtfZ86j_ggaCRA";
  String header = "What are You looking for?";

  YoutubeAPI youtube = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];

  void callAPI() async {
    videoResult = await youtube.search(
      TextBox.ytsearch.text,
      order: 'relevance',
      videoDuration: 'any',
    );
    videoResult = await youtube.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.grey[900],
        title: typing ? TextBox() : Text(header),
        leading: IconButton(
          icon: Icon(typing ? Icons.done : Icons.search),
          onPressed: () {
            setState(() {
              typing = !typing;
            });
            if (typing == false) {
              callAPI();
            }
            if (TextBox.ytsearch.text == null) {
              header = 'What are You looking for?';
            } else {
              header = TextBox.ytsearch.text;
            }
          },
        ),
      ),
      body: ListView(
        children: videoResult.map<Widget>(listItem).toList(),
      ),
    );
  }

  void _addVideo(YouTubeVideo video) {
    navigate(
      context,
      MyPlayer(id: video.id!),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return Card(
        color: Colors.grey[850],
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          padding: EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.network(
                  video.thumbnail.small.url ?? '',
                  width: 120.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      video.title,
                      softWrap: true,
                      style: TextStyle(fontSize: 18.0, color: Colors.grey[500]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        video.channelTitle,
                        softWrap: true,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(onPressed: (){_addVideo(video);}, child: Text("Play"))
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class TextBox extends StatelessWidget {
  static TextEditingController ytsearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.only(right: 50),
        child: TextField(
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Search'),
          controller: ytsearch,
        ),
      ),
    );
  }
}
