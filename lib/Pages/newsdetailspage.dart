import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Newsdetailspage extends StatefulWidget {
  String image;
  String description;
  String title;
  String source;
  String ptime;
  Newsdetailspage(
      {super.key,
      required this.description,
      required this.image,
      required this.ptime,
      required this.source,
      required this.title});

  @override
  State<Newsdetailspage> createState() => _NewsdetailspageState();
}

class _NewsdetailspageState extends State<Newsdetailspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News details',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: widget.image,
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
          SizedBox(
            height: 20,
          ),
          Text(
            "Title:" + widget.title,
            style: TextStyle(
                color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Description:" + widget.description,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Source name:" + widget.source,
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              Text(
                "PublishedAt:" + widget.ptime,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
