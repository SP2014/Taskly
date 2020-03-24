import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final String username;
  const ChatView({Key key, this.username}) : super(key: key);
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController _text = TextEditingController();
  ScrollController _scroll = ScrollController();
  var chldList = <Widget>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Stack(fit: StackFit.loose, children: <Widget>[
      Divider(height: 0, color: Colors.black26),
      Container(
          color: Colors.white,
          height: 50,
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextFormField(
                maxLines: 20,
                controller: _text,
                
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {},
                  ),
                  
                  border: InputBorder.none,
                  hintText: "Enter your message",
                ),
              )))
    ]))));
  }
}
