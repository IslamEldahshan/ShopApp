import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/modules/address/address_screen.dart';
import 'package:shop_app/shop_cubit/cubit.dart';
import 'package:shop_app/shop_cubit/states.dart';
import '../../shop_cubit/cubit.dart';

class ProductDetails extends StatelessWidget {
   ProductDetails({Key? key}) : super(key: key);

   var controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: cubit.carts[cubit.homeModel!.data!.products[cubit.index!]['id']]! ? defaultColor : Colors.grey,
            onPressed: () {
              // navigateTo(context, AddressScreen());
              cubit.changeCarts(cubit.homeModel!.data!.products[cubit.index!]['id']);
            },
            child: const Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          body: buildProductDetails(cubit.homeModel!.data!.products[cubit.index!], context,),
        );
      },
    );
  }

  Widget buildProductDetails(model, context)=> SingleChildScrollView(
    child: Column(
      children: [
        Container(
          height: 260.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              PageView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Image(
                      image: NetworkImage(model['images'][index]),
                      ),
                controller: controller,
                physics: const BouncingScrollPhysics(),
                itemCount: model['images'].length,
              ),
              Row(
                children: [
                  if(model['discount'] != 0)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        color: Colors.red,
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    child: IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model['id']);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopCubit.get(context).favorites[model['id']]! ? defaultColor : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        Container(
          height: 15.0,
          color: Colors.grey.shade200,
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model['name'],
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Description:',
                style: TextStyle(
                  color: defaultColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              ReadMoreText(
                model['description'].toString().toLowerCase(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                trimLines: 8,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'show more',
                trimExpandedText: 'less',
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Price: ',
                      style: TextStyle(
                        color: defaultColor,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Current Price
                    Text(
                      '${model['price']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    // Old Price
                    if(model['discount'] != 0)
                      Text(
                      '${model['old_price']}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 19.0,
                          decoration: TextDecoration.lineThrough,
                        ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ],
    ),
  );

}
