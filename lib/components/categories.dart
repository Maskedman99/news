import 'package:flutter/material.dart';
import 'package:newsmock/components/article.dart';
import 'package:newsmock/helper/news.dart';
import 'package:newsmock/models/categories_model.dart';
import 'package:newsmock/helper/data.dart';

class Categories extends StatefulWidget {
  final String category;
  Categories({this.category});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<CategoryModel> categories = new List<CategoryModel>();
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  void getNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getCategoryNews(widget.category);
    newslist = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            leading: new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {},
            ),
            centerTitle: true,
            title: new Text('Explore', style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ]),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(children: <Widget>[
                    Container(
                        height: 65,
                        child: ListView.builder(
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SelectedCategoriesCard(
                                  categories[index].categoryName,
                                  widget.category);
                            })),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: newslist.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return NewsCard(
                              newslist[index].urlToImage ?? "",
                              newslist[index].title ?? "",
                              newslist[index].description ?? "",
                              newslist[index].articleUrl ?? "",
                            );
                          }),
                    ),
                  ]),
                ),
              ));
  }
}

class SelectedCategoriesCard extends StatelessWidget {
  final String categoryName, selectedCategory;
  SelectedCategoriesCard(this.categoryName, this.selectedCategory);

  @override
  Widget build(BuildContext context) {
    return categoryName != selectedCategory
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Categories(
                            category: categoryName,
                          )));
            },
            child: Container(
              child: Center(
                  child: Text('#$categoryName',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ))),
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(8.0),
              decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey[400], width: 2),
                  borderRadius: new BorderRadius.circular(30)),
            ))
        : Container(
            child: Center(
                child: Text('#$categoryName',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ))),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(30),
                color: Colors.black));
  }
}

class NewsCard extends StatelessWidget {
  final String imgurl, title, desc, url;
  NewsCard(this.imgurl, this.title, this.desc, this.url);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Article(
                        url: url,
                      )));
        },
        child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400], width: 0),
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[200],
            ),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: Image.network(imgurl),
                ),
                SizedBox(height: 8),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        SizedBox(height: 4),
                        Text(desc, overflow: TextOverflow.ellipsis)
                      ],
                    ))
              ],
            )));
  }
}
