import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobileapp/urls.dart';

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
      backgroundColor: Color(0xFFdde0e3),
      appBar: AppBar(
        title: Text('Update Note'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 10,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.client.patch(urlDeleteUpdate(widget.id),
                    body: {'email': controller.text});
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
