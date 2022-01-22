import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/network/constants.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: ThemeData.light().scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                icon: const Icon(
                  Icons.power_settings_new_rounded,
                  color: Colors.red,
                ),
              ),
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search_outlined))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps_outlined), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outlined), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
