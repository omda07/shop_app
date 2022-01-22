import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/network/constants.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token!;
                navigateAndFinish(context, const ShopLayout());
              });
              showToast(
                  message: '${state.loginModel.message}',
                  state: ToastStates.SUCCESS);
            } else {
              showToast(
                  message: '${state.loginModel.message}',
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) => Container(
          color: Colors.white,
          child: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.purple),
                        ),
                        Text(
                          'register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please enter your name';
                            }
                            // return null;
                          },
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          decoration: InputDecoration(
                            label: const Text('name'),
                            prefix: const Icon(
                              Icons.person,
                              color: Colors.purple,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please enter your email address';
                            }
                            // return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            label: const Text('Email Address'),
                            prefix: const Icon(
                              Icons.mail_outline_outlined,
                              color: Colors.purple,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'password too short';
                            }
                            //return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          obscureText: RegisterCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            // suffix: Icon(RegisterCubit.get(context).suffix),
                            prefix: const Icon(
                              Icons.lock_outline,
                              color: Colors.purple,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(RegisterCubit.get(context).suffix),
                              onPressed: () {
                                RegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            // if (formKey.currentState != null &&
                            //     formKey.currentState!.validate()) {
                            //   RegisterCubit.get(context).userRegister(
                            //       email: emailController.text,
                            //       password: passwordController.text,
                            //       name: nameController.text,
                            //       phone: phoneController.text);
                            // }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please enter your phone number';
                            }
                            // return null;
                          },
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          decoration: InputDecoration(
                            label: const Text('Phone Number'),
                            prefix: const Icon(
                              Icons.phone,
                              color: Colors.purple,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState != null &&
                                    formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text);
                                  print(emailController.text);
                                  print(passwordController.text);
//print('validated');
                                } else {
                                  print('not validated');
                                }
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                              color: Colors.purple,
                            ),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
