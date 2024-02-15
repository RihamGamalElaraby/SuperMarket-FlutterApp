import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supermarket/cubit/cubit.dart';
import 'package:supermarket/cubit/states.dart';
import 'package:supermarket/models/HomeModel.dart';
import 'package:supermarket/models/categoriesModel.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuperMarketCubit, SuperMarketStates>(
      listener: (context, state) {
        if (state is SuperSucssesChangeFavouriteDataState) {
          if (!state.model.status!) {
            Fluttertoast.showToast(
              msg: state.model.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.black,
              fontSize: 16.0,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SuperMarketCubit.get(context).homeModel != null &&
              SuperMarketCubit.get(context).categoriesModel != null,
          builder: (context) => productsBuilder(
            context,
            SuperMarketCubit.get(context).homeModel!,
            SuperMarketCubit.get(context).categoriesModel!,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: Colors.teal,
            ),
          ),
        );
      },
    );
  }

  Widget productsBuilder(
      BuildContext context, HomeModel model, CategoriesModel categoriesModel) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider(
            items: model.data!.banners!
                .map(
                  (e) => Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        e.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return PlaceholderImage(); // Show a placeholder image
                        },
                      );
                    },
                  ),
                )
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
          ),
          SizedBox(height: 20),
          Text(
            'Categories',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 120, // Adjust the height as needed
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildCategoryItem(categoriesModel.data!.data![index]),
              separatorBuilder: (context, index) => SizedBox(width: 5),
              itemCount: categoriesModel.data!.data!.length,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'New Products',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height *
                0.5, // Adjust the height as needed
            child: GridView.count(
              childAspectRatio: 1 / 1.49,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: (model.data?.products ?? [])
                  .map((product) => buildGridProduct(product, context))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel model) => Container(
        height: 100,
        width: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.network(
              model.image!,
              height: 100,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(.6),
              width: double.infinity,
              child: Text(
                model.name!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );

  Widget buildGridProduct(productModel model, context) {
    return BlocBuilder<SuperMarketCubit, SuperMarketStates>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200, // Set a fixed height for the image
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image.network(
                      model.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return PlaceholderImage(); // Show a placeholder image
                      },
                    ),
                    if (model.discount != 0)
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                model.name ?? 'NULL',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Text(
                    'Price: ${model.price.round()}',
                    style: TextStyle(
                      color: Colors.teal[900],
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  if (model.discount != 0)
                    Text(
                      'Price: ${model.old_price.round()}',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Spacer(), // Add spacer to push the IconButton to the end
                  CircleAvatar(
                    backgroundColor: SuperMarketCubit.get(context)
                            .favourite
                            .containsKey(model.id)
                        ? SuperMarketCubit.get(context).favourite[model.id]!
                            ? Colors.teal
                            : Colors.grey
                        : Colors.grey,
                    radius: 15.0,
                    child: IconButton(
                      onPressed: () {
                        SuperMarketCubit.get(context)
                            .ChangeFacouriteData(model.id ?? 0);
                        print(model.id);
                      },
                      icon: Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 255, 212, 212),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey, // Placeholder color
      child: Center(
        child: Icon(
          Icons.error,
          color: Colors.white, // Error icon color
        ),
      ),
    );
  }
}
