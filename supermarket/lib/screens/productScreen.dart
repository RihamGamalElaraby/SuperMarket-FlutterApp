import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/cubit/cubit.dart';
import 'package:supermarket/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuperMarketCubit, SuperMarketStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SuperMarketCubit.get(context).homeModel != null,
            builder: (context) => productsBuilder(),
            fallback: (context) => Center(
                    child: CircularProgressIndicator(
                  color: Colors.teal,
                )));
      },
    );
  }

  Widget productsBuilder() => Column(
        children: [],
      );
}
