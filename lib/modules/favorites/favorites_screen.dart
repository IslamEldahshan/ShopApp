import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/modules/products/product_details.dart';
import 'package:shop_app/shop_cubit/cubit.dart';
import 'package:shop_app/shop_cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        if (ShopCubit.get(context).favoritesModel!.data!.data!.isEmpty) {
          return const Center(
            child: Text(
              'Enter Some Favorite Products...',
              style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState,
            builder: (BuildContext context) {
              return ListView.separated(
                itemBuilder: (context, index) => Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    ShopCubit.get(context).changeFavorites(
                        ShopCubit.get(context)
                            .favoritesModel!
                            .data!
                            .data![index]
                            .product!
                            .id!);
                  },
                  child: GestureDetector(
                    onTap: () {
                      ShopCubit.get(context).clickableFavItem(
                          ShopCubit.get(context)
                              .favoritesModel!
                              .data!
                              .data![index]
                              .product!
                              .id!);
                      navigateTo(context, ProductDetails());
                    },
                    child: buildListProduct(
                      ShopCubit.get(context)
                          .favoritesModel!
                          .data!
                          .data![index]
                          .product,
                      context,
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Container(
                    height: 1.0,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                  ),
                ),
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data!.data!.length,
              );
            },
            fallback: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
      },
    );
  }
}
