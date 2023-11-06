import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelCategories extends StatelessWidget {
  final List<dynamic>? categories;
  ModelCategories({this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: List.generate(categories!.length, (index) {
          return ListTile(
            title: Text(
              categories![index].toString().split("***")[0],
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Text(
              categories![index].toString().split("***")[1].trimLeft(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
    );
  }
}
