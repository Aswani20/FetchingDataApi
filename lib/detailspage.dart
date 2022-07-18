import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  var title;
  var content;

  DetailsPage(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
      ),
      body: Center(
        child: Container(
            margin: EdgeInsets.all(5),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(20)),        ),
            height: 500,
            child: Center(
          child: Card(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                        child: Text(
                      '$content',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
