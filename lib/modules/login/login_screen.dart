import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/network/constants.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
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
        builder: (context, state) {
          return Container(
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
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.purple),
                          ),
                          Text(
                            'login now to browse our hot offers',
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
                                return 'please enter your email';
                              }
                              // return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              label: const Text('Email'),
                              prefix: const Icon(Icons.mail_outline_outlined),
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
                            obscureText: LoginCubit.get(context).isPassword,
                            decoration: InputDecoration(
                              label: const Text('Password'),
                              // suffix: Icon(LoginCubit.get(context).suffix),
                              prefix: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(LoginCubit.get(context).suffix),
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              if (formKey.currentState != null &&
                                  formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => Container(
                              width: double.infinity,
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState != null &&
                                      formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                    print(emailController.text);
                                    print(passwordController.text);
//print('validated');
                                  } else {
                                    print('not validated');
                                  }
                                },
                                child: const Text(
                                  'Login',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: const Text('REGISTER'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
