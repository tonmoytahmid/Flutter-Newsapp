// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:newspaperapp/Models/newsheadline_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:newspaperapp/Pages/categorypage.dart';
import 'package:newspaperapp/Widgets/newsview.dart';

import '../View/newsheadlineview.dart';

enum FilterList { cnn, reuters, politico, aljazira }

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final newsview = Newsheadlineview();
  final formate = DateFormat('MMMM dd,yyyy');
  FilterList? selectedmenu;
  String? name = 'cnn';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "News App",
            style: TextStyle(
                color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => CategoryPage());
                },
                icon: Icon(
                  Icons.more,
                  color: Colors.black,
                )),
            PopupMenuButton<FilterList>(
                initialValue: selectedmenu,
                icon: Icon(Icons.more_vert),
                onSelected: (FilterList item) {
                  if (FilterList.cnn.name == item.name) {
                    name = 'cnn';
                  }
                  if (FilterList.reuters.name == item.name) {
                    name = 'reuters';
                  }
                  if (FilterList.aljazira.name == item.name) {
                    name = 'aljazira';
                  }
                  if (FilterList.politico.name == item.name) {
                    name = 'politico';
                  }
                  setState(() {});
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<FilterList>>[
                      PopupMenuItem(
                        value: FilterList.cnn,
                        child: Text('CNN'),
                      ),
                      PopupMenuItem(
                        value: FilterList.reuters,
                        child: Text('Reuters'),
                      ),
                      PopupMenuItem(
                        value: FilterList.politico,
                        child: Text('politico'),
                      ),
                      PopupMenuItem(
                        value: FilterList.aljazira,
                        child: Text('Al-Jazira'),
                      ),
                    ])
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 350,
              width: double.infinity,
              child: FutureBuilder<Newsheadline_model?>(
                  future: newsview.newsheadlineview(name!),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshots.data?.articles!.length,
                            itemBuilder: (context, index) {
                              final datetime = DateTime.parse(snapshots
                                  .data!.articles![index].publishedAt
                                  .toString());
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 350,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshots
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: SizedBox(
                                      height: 150,
                                      width: 300,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                snapshots.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.clip,
                                              ),
                                              Spacer(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshots
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    formate.format(datetime),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                      );
                    }
                  }),
            ),
            Newsview(
              name: name!,
            ),
          ],
        ));
  }
}
