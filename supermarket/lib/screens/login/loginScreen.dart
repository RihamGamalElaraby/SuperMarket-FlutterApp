import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supermarket/layouts/SuperLayout.dart';
import 'package:supermarket/network/local/cache_helper.dart';
import 'package:supermarket/screens/login/cubit/loginCubit.dart';
import 'package:supermarket/screens/login/cubit/loginStates.dart';
import 'package:supermarket/screens/registerScreen.dart';
import 'package:supermarket/shared/reusable.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwarController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) => {
                if (state is ShopLoginSucssesStates)
                  {
                    if (state.loginModel!.status!)
                      {
                        print(state.loginModel?.message),
                        print(state.loginModel?.data?.token),
                        CacheHelper.saveData(
                                key: 'token',
                                value: state.loginModel?.data?.token)
                            .then((value) {
                          navigateandreplace(context, SuperLayout());
                        }),
                        // Fluttertoast.showToast(
                        //     msg: state.loginModel!.message!,
                        //     toastLength: Toast.LENGTH_LONG,
                        //     gravity: ToastGravity.CENTER,
                        //     timeInSecForIosWeb: 5,
                        //     backgroundColor: Colors.green,
                        //     textColor: Colors.black,
                        //     fontSize: 16.0),
                        // navigatTo(context, SuperLayout),
                      }
                    else
                      {
                        print(state.loginModel?.message),
                        Fluttertoast.showToast(
                            msg: state.loginModel!.message!,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.red,
                            textColor: Colors.black,
                            fontSize: 16.0)
                      }
                  }
              },
          builder: (context, state) {
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
                            'Login',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            'Login now to browse our offers ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 50,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                            controller: passwarController,
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    Password: passwarController.text);
                              }
                            },
                            obscureText: LoginCubit.get(context).isObsecure,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                                icon: Icon(LoginCubit.get(context).suffix),
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                              condition: state is! ShopLoginLoadingStates,
                              builder: (context) => SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          LoginCubit.get(context).userLogin(
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ), // Text color
                                        elevation: 10.0, // Elevation
                                      ),
                                      child: const Text(
                                        'Login',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigatTo(context, const RegisterScreen());
                                  },
                                  child: const Text('REGISTER')),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
