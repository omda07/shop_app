import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/network/constants.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildListProduct(
                ShopCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data![index]
                    .product,
                context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:
                ShopCubit.get(context).favoritesModel!.data!.data!.length,
            physics: const BouncingScrollPhysics(),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
