import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String email;

  const UpdatePage(
      {Key? key, required this.client, required this.id, required this.email})
      : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 10,
          ),
          ElevatedButton(
            onPressed: () {
              var nid = widget.id;
              var updateUrl = Uri.http('localhost:8000', '/users/$nid/');
              widget.client.patch(
                updateUrl,
                body: {'email': controller.text},
              );
              Navigator.pop(context);
            },
            child: Text('Update note'),
          )
        ],
      ),
    );
  }
}
