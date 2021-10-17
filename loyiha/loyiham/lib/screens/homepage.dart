import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:loyiham/model/countryclass.dart';
import 'package:http/http.dart' as http;
import 'package:loyiham/screens/weather.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int inde = -1;
  TextEditingController _textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: _getFromApi(),
            builder: (context, AsyncSnapshot<List<Countries>> snap) {
              var data = snap.data;
              return data != null
                  ? Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Countries",
                                  style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.black,
                                      fontFamily: "Akronim"),
                                ),
                                Text(
                                  "Find interesting country",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          TextFormField(
                            controller: _textcontroller,
                            decoration: InputDecoration(
                                prefixIcon: IconButton(
                                    onPressed: () {
                                      for (var i = 0; i < data.length; i++) {
                                        if ((data[i].name!.common ==
                                                _textcontroller.text) ||
                                            (data[i].name!.official ==
                                                _textcontroller.text)) {
                                          inde = i;
                                          break;
                                        }
                                      }
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.search)),
                                // border: OutlineInputBorder(),
                                hintText: "Type of search",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          findCountry(inde, data),
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Popular Country",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 255,
                                  width: 400,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return snap.hasData
                                          ? Container(
                                              margin: EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    "${data[index].flags!.png}",
                                                  ),
                                                ),
                                              ),
                                              height: 250,
                                              width: 190,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${data[index].name!.common}",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                TextSpan(
                                                                  text:
                                                                      "Flag:${data[index].flag}\n",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                TextSpan(
                                                                    text: ""),
                                                                TextSpan(
                                                                    text:
                                                                        "Capital:${data[index].capital![0]}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            16)),
                                                                TextSpan(
                                                                    text: "")
                                                              ])),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                    },
                                    itemCount: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.dangerous), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.flag_outlined), label: "Travel")
          ],
          currentIndex: 0,
          unselectedItemColor: Colors.blueGrey,
          fixedColor: Colors.blue,
        ));

    //   Container(
    //     margin: EdgeInsets.only(left: 20),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.only(top: 40),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 "Countries",
    //                 style: TextStyle(
    //                     fontSize: 50,
    //                     color: Colors.black,
    //                     fontFamily: "Akronim"),
    //               ),
    //               Text(
    //                 "Find interesting country",
    //                 style: TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.grey.shade900,
    //                     fontWeight: FontWeight.bold),
    //               )
    //             ],
    //           ),
    //         ),
    //         TextFormField(
    //           onChanged: (v) {},
    //           controller: _textcontroller,
    //           decoration: InputDecoration(
    //               prefixIcon:
    //                   IconButton(onPressed: () {}, icon: Icon(Icons.search)),
    //               // border: OutlineInputBorder(),
    //               hintText: "Type of search",
    //               hintStyle: TextStyle(color: Colors.grey)),
    //         ),
    //         Container(
    //           margin: EdgeInsets.only(top: 25),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 "Popular Country",
    //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //               ),
    //               Container(
    //                 height: 255,
    //                 width: 400,
    //                 child: ListView.builder(
    //                   scrollDirection: Axis.horizontal,
    //                   itemBuilder: (context, index) {
    //                     return Container(
    //                       margin: EdgeInsets.only(right: 8),
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.all(Radius.circular(10)),
    //                         image: DecorationImage(
    //                           fit: BoxFit.cover,
    //                           image: NetworkImage(
    //                             "https://source.unsplash.com/random/$index",
    //                           ),
    //                         ),
    //                       ),
    //                       height: 250,
    //                       width: 190,
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           mainAxisAlignment: MainAxisAlignment.end,
    //                           children: [
    //                             Text(
    //                               "Country name",
    //                               style: TextStyle(
    //                                   fontSize: 16,
    //                                   fontWeight: FontWeight.bold),
    //                             ),
    //                             Row(
    //                               children: [
    //                                 Expanded(
    //                                   child: RichText(
    //                                       text: TextSpan(children: [
    //                                     TextSpan(
    //                                       text: "Flag:",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 16),
    //                                     ),
    //                                     TextSpan(text: ""),
    //                                     TextSpan(
    //                                         text: "Capital:",
    //                                         style: TextStyle(
    //                                             color: Colors.grey,
    //                                             fontSize: 16)),
    //                                     TextSpan(text: "")
    //                                   ])),
    //                                 )
    //                               ],
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                   itemCount: 10,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  findCountry(int i, List<Countries> data) {
    return inde > 0
        ? InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WEatherCapital(inde, data)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.only(right: 0, top: 15),
                  height: 270,
                  width: 290,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "${data[i].flags!.png}",
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "${data[i].name!.common}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "Flag: ${data[i].flag}\n",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          TextSpan(text: ""),
                          TextSpan(
                              text: "Capital: ${data[i].capital![0]}",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18)),
                          TextSpan(text: "")
                        ]))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: 1,
            width: 1,
            child: Center(),
          );
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
