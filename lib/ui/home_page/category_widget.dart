
import 'package:flutter/material.dart';
import 'package:local_event_app/controller/app_state.dart';
import 'package:local_event_app/style_guide.dart';
import 'package:provider/provider.dart';

import '../../model/category.dart';

class CategoryWidget extends StatelessWidget {
  final Category? category;
  const CategoryWidget({super.key, this.category});


  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isSelected = appState.selectedCategoryId == category!.categoryId;
    return GestureDetector(
      onTap: (){
        if(!isSelected){
          appState.updateCategoryId(category!.categoryId);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(color: isSelected?Colors.white:  const Color(0x99FFFFFF), width: 3),
          borderRadius: BorderRadius.circular(16),
          color: isSelected? Colors.white: Colors.transparent
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(category!.icon, color: isSelected? Theme.of(context).primaryColor:Colors.white,size: 40,),
            const SizedBox(height: 10,),
            Text(category!.name, style: isSelected?selectedCategoryTextStyle:categoryTextStyle,),
          ],
        ),
      ),
    );
  }
}
