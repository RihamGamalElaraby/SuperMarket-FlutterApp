import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/cubit/cubit.dart';
import 'package:supermarket/cubit/states.dart';
import 'package:supermarket/models/favouriteModel.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuperMarketCubit, SuperMarketStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        if (state is SuperMarketLoadingGetFavouriteDataState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SuperMarketGetFavouriteDataState) {
          if (SuperMarketCubit.get(context).favouritesModel != null &&
              SuperMarketCubit.get(context).favouritesModel!.data != null) {
            // Data is available, build the list view
            return ListView.separated(
              itemBuilder: (context, index) {
                // final favouriteData = SuperMarketCubit.get(context)
                //     .favouritesModel!
                //     .data!
                //     .data![index].product;
                return buildFavItem(
                    SuperMarketCubit.get(context)
                        .favouritesModel!
                        .data!
                        .data![index]
                        .product!,
                    context);
              },
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
                color: Colors.teal,
              ),
              itemCount: SuperMarketCubit.get(context)
                  .favouritesModel!
                  .data!
                  .data!
                  .length,
            );
          } else {
            // Data is not available
            return Center(child: Text('No favourites found.'));
          }
        } else if (state is SuperFailureGetFavouriteDataState) {
          // Error occurred while loading favorites
          return Center(
              child: Text(
                  'An error occurred while loading favourites: ${state.error}'));
        } else {
          // Unexpected state
          return Center(child: Text('Unexpected state occurred.'));
        }
      },
    );
  }

  Widget buildFavItem(Product model, BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                width: 120, // Set a fixed height for the image
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image.network(
                      model!.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return PlaceholderImage(); // Show a placeholder image
                      },
                    ),
                    if (model!.discount! != 0)
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          '${model!.discount!}',
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Column(
                children: [
                  Text(
                    model!.name ?? 'NULL',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Price: ${model!.price.round()}',
                        style: TextStyle(
                          color: Colors.teal[900],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      // if (model.discount != 0)
                      Text(
                        'Price: ${model!.oldPrice.round()}',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: SuperMarketCubit.get(context)
                                .favourite
                                .containsKey(model!.id)
                            ? SuperMarketCubit.get(context)
                                    .favourite[model!.id]!
                                ? Colors.teal
                                : Colors.grey
                            : Colors
                                .grey, // Add a default color if the map doesn't contain the key
                        radius: 15.0,
                        child: IconButton(
                          onPressed: () {
                            SuperMarketCubit.get(context)
                                .ChangeFacouriteData(model!.id ?? 0);
                            print(model!.id);
                          },
                          icon: Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ////
            ],
          ),
        ),
      );
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
