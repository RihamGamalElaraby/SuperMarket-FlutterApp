import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'cubit/cubit.dart';
import 'package:supermarket/cubit/cubit.dart';
import 'package:supermarket/screens/search/cubit/cubit.dart';
import 'package:supermarket/screens/search/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your subject';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String text) {
                      SearchCubit.get(context).Search(text);
                    },
                    decoration: InputDecoration(
                      label: const Text('Search'),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  if (state is SearchSucssesState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildFavItem(
                          SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data![index],
                          context,
                        ),
                        separatorBuilder: (context, index) => Divider(
                          thickness: 1,
                        ),
                        itemCount: SearchCubit.get(context)
                            .searchModel!
                            .data!
                            .data!
                            .length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildFavItem(model, BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image.network(
                    model.image!,
                    fit: BoxFit.cover,
                    // errorBuilder: (context, error, stackTrace) {
                    //   return Placeholder(); // Show a placeholder image
                    // },
                  ),
                  if (model.discount! != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        '${model.discount!}',
                        style: TextStyle(fontSize: 10.0, color: Colors.white),
                      ),
                    )
                ],
              ),
              SizedBox(width: 10.0),
              Column(
                children: [
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          'Price: ${model.oldPrice.round()}',
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
                                .containsKey(model.id)
                            ? SuperMarketCubit.get(context).favourite[model.id]!
                                ? Colors.teal
                                : Colors.grey
                            : Colors
                                .grey, // Add a default color if the map doesn't contain the key
                        radius: 15.0,
                        child: IconButton(
                          onPressed: () {
                            SuperMarketCubit.get(context)
                                .ChangeFacouriteData(model.id ?? 0);
                            print(model.id);
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
