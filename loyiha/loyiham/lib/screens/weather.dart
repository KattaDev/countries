import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:loyiham/model/countryclass.dart';
import 'package:loyiham/model/pagoda_class.dart';
import 'package:loyiham/screens/finalpage.dart';

class WEatherCapital extends StatelessWidget {
  int index;
  List<Countries> data;
  WEatherCapital(this.index, this.data) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _getPostFromAPi(data, index),
          builder: (context, AsyncSnapshot<Pagoda> snap) {
            var datashu = snap.data;
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1624642771881-4aafd295ea5e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHV6YmVraXN0YW58ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.arrow_back),
                        backgroundColor: Colors.black12,
                      ),
                    ),
                    SizedBox(
                      height: 400,
                    ),
                    Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.cloud,
                                  size: 45,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${datashu!.weather![0].main}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    Text(
                                      "Wind: ${datashu.wind!.speed}m/s}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text(
                            "${data[index].name!.official}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${data[index].capital![0]}",
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 50),
                                onPrimary: Colors.pinkAccent,
                                primary: Colors.red.shade50),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PageviewPage()));
                            },
                            child: Text("Preview")),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 50),
                                onPrimary: Colors.pinkAccent,
                                primary: Colors.blueGrey.shade200),
                            onPressed: () { Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PageviewPage()));
                          }, child: Text("Start View"))
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future<Pagoda> _getPostFromAPi(List<Countries> data, index) async {
    var _res = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${data[index].capital![0]}&appid=8b6e346c880a98e44a35e675ff4c74ad"));
    if (_res.statusCode == 200) {
      return Pagoda.fromJson(jsonDecode(_res.body));
    } else {
      throw Exception("Error");
    }
  }
}
