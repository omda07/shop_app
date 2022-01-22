import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/network/constants.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var model = ShopCubit.get(context).userModel;
    nameController.text = model!.data!.name!;
    emailController.text = model.data!.email!;
    phoneController.text = model.data!.phone!;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUpdateUserDataState) {
          if (state.userModel.status!) {
            CacheHelper.putData(
                    key: 'token', value: state.userModel.data!.token!.isEmpty)
                .then((value) {
              token = state.userModel.data!.token!;
            });
            showToast(
                message: '${state.userModel.message}',
                state: ToastStates.SUCCESS);
          } else {
            showToast(
                message: '${state.userModel.message}',
                state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel!.data!.token != null &&
              ShopCubit.get(context).userModel != null,
          builder: (context) => Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserDataState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
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
                        label: const Text('Name'),
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
                      height: 15.0,
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
                          return 'please enter your phone number';
                        }
                        // return null;
                      },
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        label: const Text('Phone'),
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
                      height: 15.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState != null &&
                              formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          } else {
                            print('not validated');
                          }
                        },
                        child: const Text(
                          'Update',
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
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
