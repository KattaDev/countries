import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loyiham/model/countryclass.dart';
import 'package:loyiham/model/pagoda_class.dart';

class PageviewPage extends StatefulWidget {
  const PageviewPage({Key? key}) : super(key: key);

  @override
  _PageviewPageState createState() => _PageviewPageState();
}

class _PageviewPageState extends State<PageviewPage> {
  int initialpage1 = 0;
  var _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder(
          future: _getFromApi(),
          builder: (context, AsyncSnapshot<List<Countries>> snap) {
            var data = snap.data;
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    child: PageView(
                      onPageChanged: (i) {
                        setState(() {
                          initialpage1 = i;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      children: [
                        Container(
                          height: 280,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://media.istockphoto.com/photos/mount-hood-oregon-picture-id1268487061?b=1&k=20&m=1268487061&s=170667a&w=0&h=3fHYwaImlqUETcjCnSV7YO2-PzCFvaX6VSQaiGfWqpc="))),
                        ),
                        Container(
                          height: 280,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://media.istockphoto.com/photos/wheat-field-picture-id1295797304?b=1&k=20&m=1295797304&s=170667a&w=0&h=HtuSpoguTv7peVj6K3mY6UBHcF-Hfbp2t1icxTifrhg="))),
                        ),
                        Container(
                          height: 280,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1447752875215-b2761acb3c5d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 165, top: 10),
                    height: 20,
                    width: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: index == initialpage1
                                  ? Colors.black
                                  : Colors.grey),
                          height: index == initialpage1 ? 15 : 8,
                          width: index == initialpage1 ? 20 : 10,
                          margin: EdgeInsets.all(2),
                        );
                      },
                      itemCount: 3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "${data![initialpage1].name!.common}\n${data[initialpage1].name!.official}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "${data[initialpage1].capital![0]}",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          radius: 25,
                          child: IconButton(
                            icon: Icon(
                              Icons.call,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          radius: 25,
                          child: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              launch(data[initialpage1].maps!.googleMaps.toString());
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          radius: 25,
                          child: IconButton(
                            icon: Icon(
                              Icons.subdirectory_arrow_right_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          radius: 25,
                          child: IconButton(
                            icon: Icon(
                              Icons.call,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text("Follow"),
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(110, 43),
                            primary: Colors.teal,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                    child: Text(
                      "Information",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.black,
                              ),
                              Text("4.5")
                            ],
                          ),
                          Text(
                            "4.5 Review",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [Text("3585")],
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.flag_outlined,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          Text(
                            "12 hours",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                        """Uzbekistan is a Central Asian nation and former Soviet republic. It's known for its mosques, mausoleums and other sites linked to the Silk Road, the ancient trade route between China and the Mediterranean. Samarkand, a major city on the route, contains a landmark of Islamic architecture: the Registan, a plaza bordered by 3 ornate, mosaic-covered religious schools dating to the 15th and"""),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    height: 80,
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Show More Info",
                          style: TextStyle(fontSize: 20),
                        ),
                        Icon(
                          Icons.arrow_right_sharp,
                          size: 25,
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageviewPage()));
                          },
                          child: Text("Start View"))
                    ],
                  )
                ],
              ),
            );
          }),
    ));
  }

  Future<List<Countries>> _getFromApi() async {
    try {
      var _res = await http.get(
        Uri.parse("https://restcountries.com/v3.1/all"),
      );
      if (_res.statusCode == 200) {
        return (json.decode(_res.body) as List)
            .map((e) => Countries.fromJson(e))
            .toList();
      } else {
        throw Exception("ERROR");
      }
    } catch (e) {
      throw Exception("Error");
    }
  }
}
//https://api.openweathermap.org/data/2.5/weather?q=London&appid=8b6e346c880a98e44a35e675ff4c74ad