import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    TextFormField(
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter your search';
                        }
                        return null;
                      },
                      onFieldSubmitted: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      decoration: InputDecoration(
                        label: const Text('Search'),
                        prefix: const Icon(
                          Icons.search,
                          color: Colors.purple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data![index],
                              context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)
                              .model!
                              .data!
                              .data!
                              .length,
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
