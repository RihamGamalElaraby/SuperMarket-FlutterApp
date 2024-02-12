import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/cubit/cubit.dart';
import 'package:supermarket/cubit/states.dart';
import 'package:supermarket/models/HomeModel.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuperMarketCubit, SuperMarketStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SuperMarketCubit.get(context).homeModel != null,
            builder: (context) => productsBuilder(
                context, SuperMarketCubit.get(context).homeModel!),
            fallback: (context) => Center(
                    child: CircularProgressIndicator(
                  color: Colors.teal,
                )));
      },
    );
  }

  Widget productsBuilder(BuildContext context, HomeModel? model) {
    if (model == null) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.teal,
        ),
      );
    } else {
      return Column(
        children: [
          CarouselSlider(
            items: model.data!.banners!
                .map((e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              height: 250.5,
              initialPage: 0,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      );
    }
  }
}
