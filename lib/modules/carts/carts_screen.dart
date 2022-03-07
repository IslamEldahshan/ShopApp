import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/shop_cubit/cubit.dart';
import 'package:shop_app/shop_cubit/states.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context).cartModel!.data!;
        return Scaffold(
            appBar: AppBar(),
            body: (ShopCubit.get(context).cartModel!.data!.cartItems.isEmpty) ? const Center(
                    child: Text(
                      'Buy Some Products...',
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ) : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildCartItem(cubit, context, index);
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Container(
                        height: 2.0,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    itemCount: ShopCubit.get(context)
                        .cartModel!
                        .data!
                        .cartItems
                        .length,
                  ));
      },
    );
  }

  Widget buildCartItem(
    model,
    context,
    index,
  ) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 150.0,
              width: double.infinity,
              child: Image(
                image: NetworkImage(model.cartItems[index]['product']['image']),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              model.cartItems[index]['product']['name'],
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                const Text(
                  'Price:',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 19.0,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  '${model.cartItems[index]['product']['price']}',
                  style: const TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: ShopCubit.get(context)
                            .carts[model.cartItems![index]['product']['id']]!
                        ? defaultColor
                        : Colors.grey,
                    child: IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeCarts(
                            model.cartItems[index]['product']['id']);
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (index ==
                ShopCubit.get(context).cartModel!.data!.cartItems.length - 1)
              if (ShopCubit.get(context).cartModel!.data!.cartItems.length != 1)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Total price: ',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${ShopCubit.get(context).cartModel!.data!.total.round()}',
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      );
}
