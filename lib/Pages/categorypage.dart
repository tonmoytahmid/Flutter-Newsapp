import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:newspaperapp/Models/categorymodel.dart';
import 'package:newspaperapp/Pages/newsdetailspage.dart';
import 'package:newspaperapp/View/categoryview.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> categories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];

  String selectedCategory = "business"; 
  final formate = DateFormat('MMMM dd,yyyy');

  final categoryview= Categoryview();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"
        ,style: TextStyle(color: Colors.blue),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String category = categories[index];
                bool isSelected = category == selectedCategory;
            
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category.toUpperCase(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      
      
          Expanded(
            child: FutureBuilder<Categorymodel?>(
                    future: categoryview.categoryview(selectedCategory),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
                      } else {
            return SizedBox(
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
                    }),
          )
        ],
      ),
    );
  }
}
