import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/screen/recipe_page.dart';
import 'package:recipe_app/services/data_service.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _mealTypeFilter = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recipe Book'),
      ),
      body: SafeArea(child: _buildUI()),
    );
  }
  Widget _buildUI(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _recipeTypeButtons(),
          _recipeList()

        ],
      ),

    );
  }
  Widget _recipeTypeButtons(){
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(onPressed: (){
              setState(() {
                _mealTypeFilter = 'snack';
              });
            }, child: const Text('🥕 Snack')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(onPressed: (){
              setState(() {
                _mealTypeFilter = 'breakfast';
              });
            }, child: const Text('Breakfast')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(onPressed: (){
              setState(() {
                _mealTypeFilter = 'lunch';
              });
            }, child: const Text('🥩 Lunch')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(onPressed: (){
              setState(() {
                _mealTypeFilter = 'dinner';
              });
            }, child: const Text('Dinner')),
          ),
        ],

      ),

    );
  }
  Widget _recipeList() {
    return Expanded(
      child: FutureBuilder(
        future: DataService().getRecipes(_mealTypeFilter),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Unable to load Data'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Recipe recipe = snapshot.data![index];

              return ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return  RecipePage(recipe: recipe,);
                  }));
                },
                contentPadding: const EdgeInsets.only(top: 20),
                isThreeLine: true,// Return the ListTile here
                title: Text(recipe.name),
                subtitle: Text('${recipe.cuisine}\nDifficulty: ${recipe.difficulty}'),
                leading: Image(image: NetworkImage(recipe.image)),
                trailing: Text('${recipe.rating.toString()} ⭐', style: const TextStyle(
                  fontSize: 15
                ),),
              );
            },
          );
        },
      ),
    );
  }

}
