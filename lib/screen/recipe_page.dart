import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/path.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  const RecipePage({super.key, required this.recipe});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
   Recipe? recipe;
    List<bool>? _checkedStates;

  @override
  void initState() {
    super.initState();
    recipe = widget.recipe;// Assign widget.recipe to a local variable
    _checkedStates = List<bool>.filled(recipe!.ingredients.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white60,
        title: const Text('Recipe Book'),
      ),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipeImage(context),
          _recipeDetails(context),
          _recipeIngridents(context),
          _recipeInstruction(context),

          /*ClipPath(
            clipper: TsClip3(),
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://cdn.britannica.com/q:60/84/203584-050-57D326E5/speed-internet-technology-background.jpg"))),
            ),
          ),
          Center(child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(onPressed: (){}, child: const Text("Developed By"),),
          )),
          const Center(child: Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text("Sharif"),
          )),*/

        ],
      ),
    );
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(recipe!.image),
          fit: BoxFit.cover,  // Now you can use recipe.image
        ),
      ),
    );
  }
  Widget _recipeDetails(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      color: Colors.white60,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('${recipe!.cuisine}  ${recipe!.difficulty}', style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300
          ),),
          Text(recipe!.name, style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
          Text('Prep Time ${recipe!.prepTimeMinutes} Minutes |  Cook Time ${recipe!.cookTimeMinutes} Minutes', style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300
          ),),
          Text('${recipe!.rating} ⭐ |  ${recipe!.reviewCount}', style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500
          ),),
        ],
      ),

    );
  }
  Widget _recipeIngridents(BuildContext context){
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: Column(
        children: recipe!.ingredients.asMap().entries.map((entry) {
          int index = entry.key;
          String ingredient = entry.value;
          return Row(
            children: [
              Checkbox(
                value: _checkedStates![index],
                onChanged: (bool? value) {
                  setState(() {
                    _checkedStates?[index] = value!;
                  });
                },
              ),
              Text(ingredient),
            ],
          );
        }).toList(),
      ),
    );

  }
  Widget _recipeInstruction(BuildContext context){
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: Column(
        children:
        recipe!.instructions.map((i){
          return Text(' (${recipe!.instructions.indexOf(i)}) $i\n', maxLines: 3,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15
          ),);

        }).toList()
      ),


    );
  }
}
