import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/cubit/cubit.dart';
import 'package:supermarket/cubit/states.dart';
import 'package:supermarket/screens/searchScreen.dart';
import 'package:supermarket/shared/reusable.dart';

class SuperLayout extends StatelessWidget {
  const SuperLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuperMarketCubit, SuperMarketStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var cubit = SuperMarketCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Super Market',
                style: TextStyle(color: Colors.deepOrange[900]),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigatTo(context, SearchScreen());
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.deepOrange[900],
                    ))
              ],
            ),
            body: cubit.bottomScreens[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.deepOrange,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  cubit.changeBottomIndex(index);
                },
                currentIndex: cubit.currentindex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.grid_view_sharp), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favourite'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Setting')
                ]),
          );
        });
  }
}
