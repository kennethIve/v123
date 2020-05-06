import 'package:flutter/material.dart';
import 'package:recipe/model/recipeModel.dart';

class RecipeDetailPage extends StatelessWidget {
  
  const RecipeDetailPage({Key key, this.title, this.recipe}) : super(key: key);
  final String title;
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(),
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          body: Center(
            child:Text("Recipe Detail Page",style: TextStyle(color: Colors.white,fontSize: 20.0),)
            ),
        )
    );
  }
} 