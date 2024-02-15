import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/cubit/cubit.dart';
import 'package:supermarket/cubit/states.dart';
import 'package:supermarket/models/categoriesModel.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuperMarketCubit, SuperMarketStates>(
      listener: (context, state) => {},
      builder: (context, state) => ListView.separated(
          itemBuilder: (context, index) => BuildCatItem(
              SuperMarketCubit.get(context)
                  .categoriesModel!
                  .data!
                  .data![index]),
          separatorBuilder: (context, index) => Divider(
                thickness: 1,
                color: Colors.teal,
              ),
          itemCount: SuperMarketCubit.get(context)
              .categoriesModel!
              .data!
              .data!
              .length),
    );
  }

  Widget BuildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              model.name!,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_circle_right)
          ],
        ),
      );
}
