import 'package:flutter/material.dart';
import 'package:recipe/com_var.dart';
import 'package:recipe/component/drawer.dart';
import 'package:recipe/model/recipeModel.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({Key key, this.title, this.recipe}) : super(key: key);
  final String title;
  final Recipe recipe;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: topBar(),
          drawer: SideBar(),
          backgroundColor: Colors.white,//Color.fromRGBO(58, 66, 86, 1.0),
          body: Container(
              child:Text("Search Page",style: TextStyle(color: Colors.black,fontSize: 20.0),)
            ),
        )
    );
  }
}