import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supermarket/layouts/SuperLayout.dart';
// import 'package:supermarket/screens/register/cubit/registerCubit.dart';
import 'package:supermarket/network/local/cache_helper.dart';
import 'package:supermarket/screens/register/cubit/registerCubit.dart';
import 'package:supermarket/screens/register/cubit/registerStates.dart';
import 'package:supermarket/shared/reusable.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  RegisterScreen({super.key});

  var passwarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
      if (state is ShopRegisterSuccessStates) {
        if (state.loginModel!.status!) {
          print(state.loginModel?.message);
          print(state.loginModel?.data?.token);
          CacheHelper.saveData(
                  key: 'token', value: state.loginModel?.data?.token)
              .then((value) {
            token = state!.loginModel!.data!.token!;
            Fluttertoast.showToast(
                msg: state.loginModel!.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.black,
                fontSize: 16.0);
            navigatTo(context, SuperLayout);
          });
        } else {
          print(state.loginModel?.message);
          Fluttertoast.showToast(
              msg: state.loginModel!.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.black,
              fontSize: 16.0);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'Register now to browse our offers ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 50,
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
                        label: const Text('Name'),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 5.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Icon(Icons.person),
                        hintText: 'Name',
                      ),
                    ),
                    const SizedBox(
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
                        label: const Text('E-mail'),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 5.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Icon(Icons.email),
                        hintText: 'email',
                      ),
                    ),
                    const SizedBox(
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
                        label: const Text('Phone'),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 5.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Icon(Icons.phone),
                        hintText: 'Phone',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwarController,
                      onFieldSubmitted: (value) {
                        // if (formKey.currentState!.validate()) {
                        //   RegisterCubit.get(context).userRegister(
                        //       name: nameController.text,
                        //       phone: phoneController.text,
                        //       email: emailController.text,
                        //       Password: passwarController.text);
                        // }
                      },
                      obscureText: RegisterCubit.get(context).isObsecure,
                      validator: (value) {
                        if (value == null) {
                          return 'please enter your passward';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Passward'),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 5.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.lock),
                          onPressed: () {},
                        ),
                        hintText: 'passward',
                        suffixIcon: IconButton(
                          icon: Icon(RegisterCubit.get(context).suffix),
                          onPressed: () {
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingStates,
                        builder: (context) => SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        phone: phoneController.text,
                                        name: nameController.text,
                                        email: emailController.text,
                                        Password: passwarController.text);
                                  }
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
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        fallback: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.deepOrange,
                              ),
                            )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
