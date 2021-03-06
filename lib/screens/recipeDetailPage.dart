import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe/model/recipeModel.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

import '../com_var.dart';

class RecipeDetailPage extends StatelessWidget {
  

  

  
  const RecipeDetailPage({Key key, this.title, this.recipe}) : super(key: key);
  final String title;
  final Recipe recipe;
  static var _scrollController = ScrollController();

  final double cardRadius = 15.0;
  static const double fontSize = 15.0;
  static const double iconSize = 18.0;
  static const List<Widget> levels = [
    Icon(Icons.looks_one,size: iconSize,color: Colors.grey,),
    Icon(Icons.looks_two,size: iconSize,color: Colors.grey,),
    Icon(Icons.looks_3,size: iconSize,color: Colors.grey,),
    Icon(Icons.looks_4,size: iconSize,color: Colors.grey,),
    Icon(Icons.looks_5,size: iconSize,color: Colors.grey,),
    Icon(Icons.looks_6,size: iconSize,color: Colors.grey,),    
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: topBar(type: "custom",title: "Recipe Details"),
          backgroundColor: commonBackground,
          body: Container(  
            alignment: Alignment.center,            
            padding: EdgeInsets.symmetric(horizontal: 10),
            //color: Colors.transparent,
            child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Card(
                      elevation: 5,
                      //borderOnForeground: true,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardRadius)),
                      margin: EdgeInsets.all(10),
                      child: Column(                      
                      children:[
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top:Radius.circular(cardRadius),),
                          child: Image.network(
                            recipe.image,fit: BoxFit.fitWidth,                      
                            loadingBuilder: (context,child,progress){
                            if (progress == null) return child; 
                              return Center(
                                child: CircularProgressIndicator(value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes : null,),
                              );
                            },
                          ),
                        ),
                        ExpansionTile(
                          title: Text(recipe.title,style: GoogleFonts.notoSerif(textStyle: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold,)),textAlign: TextAlign.start,softWrap: true,),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end, 
                            children:[
                              SmoothStarRating(starCount: 5,rating: recipe.getRating(),isReadOnly: true,size: fontSize,color: Colors.orange,),
                              time(),
                              skillTerm(),
                            ],                            
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                              child: desc(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(onPressed: _launchURL,child: Text('Details',style: TextStyle(color:Colors.blue),),)
                              ],
                            ),
                          ],
                          initiallyExpanded: true,
                        ),
                        ExpansionTile(
                          title: Text("Ingredients"),
                          children: [ingredientList()],
                        ),
                        ExpansionTile(                          
                          title: Text("Steps"),
                          children: [steps()],
                        ),
                      ], 
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget time(){
    return 
      Container(
        child: Row(
          children: [Icon(Icons.timer,size: 13,color: Colors.grey,),
            Text(recipe.getDuration(),style:TextStyle(fontSize:fontSize,fontFamily: "Serif")),
            Text(" mins",style:TextStyle(fontSize:13,fontFamily: "Serif")),                    
        ]),
      );
  }
  Widget skillTerm(){
    return 
      Container(
        child: Row(
          children: [
            Text("Level:",style:TextStyle(fontSize:fontSize,fontFamily: "Serif")),
            levels[recipe.skillTerm],
        ]),
      );
  }
  Widget desc(){
    return Text(
      recipe.description,
      style: TextStyle(
        fontSize: fontSize,color: Colors.black45
      ),
    );
  }
  //image widget
  Widget img(){
    return Padding(
      padding: EdgeInsets.all(10),
      child:AspectRatio(      
        aspectRatio: 1.0 / 2.0,
        child: Image.network(          
          recipe.image,
          fit: BoxFit.cover,          
        ),
      )
    );
  
  }
  Widget ingredientList(){
    return new ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: recipe.ingredients.length,
      itemBuilder: (context,index){
        Ingredient temp = recipe.ingredients[index];
        return ListTile(
          leading: CircleAvatar(child: Text(temp.getSeq()),),
          title:Text(
            temp.content,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              wordSpacing: 1.5,
            )
          ),
        );
      }
    );
  }

  Widget steps(){
    return new ListView.builder(
      shrinkWrap: true,      
      controller: _scrollController,
      itemCount: recipe.steps.length,
      itemBuilder: (context,index){
        Steps temp = recipe.steps[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              temp.getSeq(),
              style: TextStyle(
                fontStyle: FontStyle.italic,
                wordSpacing: 1.5,
              ),
            ),
          ),
          title:Text(
            temp.description,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              wordSpacing: 1.5,
            ),
          ),
        );
      }
    );
  }

  _launchURL() async {
    String url = recipe.resoureceUrl;
    debugPrint(url);
    if (await canLaunch(url)) 
    {
      await launch(url);
    } 
    else 
    {
      throw 'Could not launch $url';
    }
  }
  
} 