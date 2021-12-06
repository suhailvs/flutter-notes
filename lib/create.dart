import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobileapp/urls.dart';

class CreatePage extends StatefulWidget {
  final Client client;
  const CreatePage({Key? key, required this.client}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFdde0e3),
      appBar: AppBar(
        title: Text('Create Note'),
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
                widget.client.post(urlRetrieveCreate(), body: {
                  "firstName": "f name",
                  "email": controller.text,
                  "lastName": "l name"
                }); // {'email': controller.text});
                Navigator.pop(context);
              },
              child: Text("Create"),
            )
          ],
        ),
      ),
    );
  }
}
