import 'dart:convert';
import 'package:fetchingapi/detailspage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Presentation layer
class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DataScreen();
  }
}

class _DataScreen extends State<DataScreen> {
  late Future<List<Data>> data;

  @override
  void initState() {
    super.initState();
    data = DataApi().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var _data = (snapshot.data as List<Data>);
              return ListView.builder(itemCount:_data.length ,itemBuilder: (context,index)=> DataItems(_data[index]));
              return Container();
            } else if (snapshot.hasError) {
              return Container(
                child: Text('Erorr'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );

            }
          }),
    );
  }
}

class DataItems extends StatelessWidget{

  var _data;
  DataItems(this._data);

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.all(5),
        // padding: const EdgeInsets.all(5.0),
        // decoration: BoxDecoration(
        //   border: Border.all(width: 3, color: Colors.blue),
        //   borderRadius: BorderRadius.all(Radius.circular(20)),        ),
        height: 170,
        child: Center(
          child: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return DetailsPage(_data.title,_data.content);
            }));
          },child: Card(
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Image.network(_data.picture),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(_data.title)],
                ),

              ],
            ),
          ),),
        ));
  }

}

//Domain layer
class Data {
  String title;
  String picture;
  String content;
  String id;

  Data(this.title, this.picture, this.content, this.id);

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      json['title'],
      json['picture'],
      json['content'],
      json['id'],
    );
  }
}

//Data layer
class DataApi {
  Future <List<Data>> fetchData() async {
    var response = await http.get(
        Uri.parse("https://62d4154fcd960e45d452f790.mockapi.io/api/article"));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var list =(jsonResponse as List).map((e) => Data.fromJson(e)).toList();
      return list;
    } else {
      throw Exception('error');
    }
  }
}
