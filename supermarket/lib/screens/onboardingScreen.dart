import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:supermarket/cubit/cubit.dart';
import 'package:supermarket/cubit/states.dart';
import 'package:supermarket/network/local/cache_helper.dart';
import 'package:supermarket/shared/reusable.dart';

import 'login/loginScreen.dart';

class boardingModel {
  final String image;
  final String title;
  final String body;

  boardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var isLast = false;
  List<boardingModel> boarding = [
    boardingModel(
      image: 'assets/images/onboarding1.jpg',
      body: 'on 1 title',
      title: 'on board body',
    ),
    boardingModel(
      image: 'assets/images/onboarding2.jpg',
      body: 'on 2 title',
      title: 'on board body',
    ),
    boardingModel(
      image: 'assets/images/onboarding3.png',
      body: 'on 3 title',
      title: 'on board body',
    ),
  ];
  var boarderController = PageController();
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateandreplace(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuperMarketCubit, SuperMarketStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(actions: [
              TextButton(
                  onPressed: submit,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange[900],
                    ),
                  )),
              IconButton(
                onPressed: () {
                  SuperMarketCubit.get(context).changeAppMode();
                },
                icon: const Icon(Icons.brightness_2_rounded),
                color: SuperMarketCubit.get(context).isDark
                    ? Colors.white
                    : Colors.brown,
              ),
            ]),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: boarderController,
                      onPageChanged: (int index) {
                        if (index == boarding.length - 1) {
                          setState(() {
                            isLast = true;
                          });
                        } else {
                          setState(() {
                            isLast = false;
                          });
                        }
                      },
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          BuildBoardingItem(boarding[index]),
                      itemCount: boarding.length,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SmoothPageIndicator(
                          controller: boarderController,
                          effect: const ExpandingDotsEffect(
                              dotColor: Colors.grey,
                              dotHeight: 10,
                              expansionFactor: 4,
                              dotWidth: 10,
                              spacing: 5,
                              activeDotColor: Colors.red),
                          count: boarding.length),
                      const Spacer(),
                      FloatingActionButton(
                        onPressed: () {
                          if (isLast) {
                            submit();
                          } else {
                            boarderController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.ease);
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ));
      },
    );
  }

  Widget BuildBoardingItem(boardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage(model.image),
          )),
          Text(
            model.title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
}
