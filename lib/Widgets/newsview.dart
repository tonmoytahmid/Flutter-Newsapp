import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:newspaperapp/Models/newsheadline_model.dart';
import 'package:newspaperapp/Pages/newsdetailspage.dart';

import '../View/newsheadlineview.dart';

class Newsview extends StatefulWidget {
  const Newsview({super.key});

  @override
  State<Newsview> createState() => _NewsviewState();
}

class _NewsviewState extends State<Newsview> {
  final newsview = Newsheadlineview();
  final formate = DateFormat('MMMM dd,yyyy');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Newsheadline_model?>(
        future: newsview.newsheadlineview(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else {
            return Container(
              height: 450,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshots.data!.articles!.length,
                  itemBuilder: (context, index) {
                    final data = snapshots.data!.articles![index];
                    final datetime = DateTime.parse(snapshots
                        .data!.articles![index].publishedAt
                        .toString());
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => Newsdetailspage(
                              image: data.urlToImage.toString(),
                              title: data.title.toString(),
                              ptime: formate.format(datetime),
                              description: data.description.toString(),
                              source: data.source!.name.toString(),
                            ));
                      },
                      child: ListTile(
                        leading: SizedBox(
                          width: 50,
                          height: 50,
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
                            errorWidget: (context, url, error) => Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          snapshots.data!.articles![index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshots.data!.articles![index].source!.name
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              formate.format(datetime),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }
}
