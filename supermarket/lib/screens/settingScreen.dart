import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/cubit/cubit.dart';
import 'package:supermarket/cubit/states.dart';
import 'package:supermarket/shared/reusable.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuperMarketCubit, SuperMarketStates>(
        listener: (context, state) => {
              // if (state is SuperMarketGetPROFILEDataState)
              //   {
              //     print(state.loginModel.data!.name!),
              //     print(state.loginModel.data!.email!),
              //     print(state.loginModel.data!.phone!),
              //     nameController.text = state.loginModel.data!.name!,
              //  /     emailController.text = state.loginModel.data!.email!,
              //     phoneController.text = state.loginModel.data!.phone!,
              // }s
            },
        builder: (context, state) {
          var model = SuperMarketCubit.get(context).userModel!;
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
          print(model.data!.name!);
          print(model.data!.email!);
          print(model.data!.phone!);
          return SingleChildScrollView(
            child: ConditionalBuilder(
                condition: SuperMarketCubit.get(context).userModel != null,
                builder: (context) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            if (state is SuperMarketLoadingeditPROFILEDataState)
                              LinearProgressIndicator(),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null) {
                                  return 'please enter your name address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('name'),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 5.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.deepOrange, width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                prefixIcon: const Icon(Icons.person),
                                hintText: 'name',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null) {
                                  return 'please enter your email address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('email'),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 5.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.deepOrange, width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                prefixIcon: const Icon(Icons.email),
                                hintText: 'email',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null) {
                                  return 'please enter your phone address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('phone'),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 5.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.deepOrange, width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                prefixIcon: const Icon(Icons.phone),
                                hintText: 'phone',
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    SuperMarketCubit.get(context)
                                        .editProfileData(
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text);
                                  }

                                  // signout(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 24.0),
                                  backgroundColor: Colors.teal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ), // Text color
                                  elevation: 10.0, // Elevation
                                ),
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  signout(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 24.0),
                                  backgroundColor: Colors.teal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ), // Text color
                                  elevation: 10.0, // Elevation
                                ),
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator())),
          );
        });
  }
}
