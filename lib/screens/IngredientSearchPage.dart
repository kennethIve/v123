import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:recipe/com_var.dart';
import 'package:recipe/component/drawer.dart';
import 'package:recipe/model/recipeModel.dart';

import 'ObjectDetectPage.dart';

class IngredientSearchPage extends StatefulWidget {
  IngredientSearchPage({Key key}) : super(key: key);

  @override
  _IngredientSearchPageState createState() => _IngredientSearchPageState();
}

class _IngredientSearchPageState extends State<IngredientSearchPage> {

  static List ingredients = [];
  static var _scrollController = ScrollController();
  
  final List<String> _gridImg = [
    "assets/ingreLogo/Fruits.png",
    "assets/ingreLogo/Meats.png",
    "assets/ingreLogo/SeaFood.png",
    "assets/ingreLogo/Vegetables.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: topBar(type: "custom",title: "Ingredient Search"),
          drawer: SideBar(),
          bottomNavigationBar: BottomAppBar(
            child: IconButton(
              color: defaultTheme.primaryColor,
              icon: Icon(Icons.camera), 
              onPressed: () async {
                ingredients.add("hello");
                setState(() {
                  
                });
                // await availableCameras().then((cameras){
                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ObjectDetectPage(cameras: cameras,)));
                // });                
              }
            ),
          ),
          backgroundColor: commonBackground,
          body: Container(
            alignment:Alignment.topCenter,
            padding: EdgeInsets.only(top:20,left: 20,right: 20,),
            child:SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: <Widget>[
                  ingredientBar(),
                  Card(
                    child:Text("Categories"),
                  ),
                  //Expanded(child: 
                    GridView.count(
                      shrinkWrap: true,
                      controller: _scrollController,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(_gridImg.length, (index) => InkWell(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: AssetImage(_gridImg[index]), fit: BoxFit.cover),          
                          ),
                          child: //Card(child: 
                            Text(_gridImg[index].split("/").last.split(".").first),
                          //),
                        ),
                       onTap: (){},
                      )
                      ).toList(),
                    ),
                  //),
                  //Text("hello"),
                ],
              ),
            )
          ),
        ),
    );
  }

  Widget ingredientBar() {
    return Card(
      elevation: 8,
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:[
            Text("Ingredients Chips",style:header),
          ]),
          leading: Icon(Icons.text_fields),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          runSpacing: 5,
          spacing: 5,
          children: List.generate(ingredients.length, (index){
            return keywordChip(ingredients[index], Colors.white);
          }),
        ),
        Padding(padding: EdgeInsets.all(5),),
       ],
      ),
    );
  }

  Widget keywordChip (String keyword,Color color){
    return new Chip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(backgroundColor: Colors.orange,child: Text(keyword.substring(0,1),style: TextStyle(color: Colors.white),),), 
      label: Text(keyword),
      backgroundColor: color,
      elevation: 4.0, 
      onDeleted: () { 
        setState(() {
          ingredients.remove(keyword);
        });
      },
    );
  }

}
