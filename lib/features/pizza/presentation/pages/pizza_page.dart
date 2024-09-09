import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/utils/assets.dart';
import 'package:pizza_app/common/utils/font_utils.dart';
import 'package:pizza_app/common/utils/size.dart';
import 'package:pizza_app/common/widgets/custom_image.dart';
import 'package:pizza_app/common/widgets/custom_wrapper.dart';
import 'package:pizza_app/common/widgets/gap.dart';

import '../bloc/pizza_bloc.dart';

class PizzaPage extends StatelessWidget {
  const PizzaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PizzaBloc()..add(LoadPizzaData()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Order Pizza',
            style: AppTextStyle.medium.copyWith(fontSize: 18),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            const Gap(width: 10)
          ],
        ),
        body: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            if (state is PizzaInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PizzaLoaded) {
              state.toppings.where((topping) {
                return topping.applicablePizzas.contains(state.selectedPizza);
              }).toList();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: state.pizzas.map((pizza) {
                          return _selectedPizaa(
                            name: pizza.name,
                            price: pizza.price.toString(),
                            value: pizza.name,
                            groupValue: state.selectedPizza,
                            onChanged: (value) {
                              context
                                  .read<PizzaBloc>()
                                  .add(UpdateSelectedPizza(value!));
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const Gap(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Size',
                        style: AppTextStyle.medium.copyWith(fontSize: 14),
                      ),
                    ),
                    const Gap(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: state.sizes.map((size) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: RadioListTile<String>(
                            title: Text(
                              size.size,
                              style: AppTextStyle.medium.copyWith(fontSize: 12),
                            ),
                            value: size.size,
                            groupValue: state.selectedSize,
                            onChanged: (value) {
                              context
                                  .read<PizzaBloc>()
                                  .add(UpdateSelectedSize(value!));
                            },
                          ),
                        );
                      }).toList(),
                    ),

                    const Gap(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Topping',
                        style: AppTextStyle.medium.copyWith(fontSize: 14),
                      ),
                    ),
                    const Gap(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        runSpacing: 16,
                        spacing: 12,
                        children: state.toppings.map((topping) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: state.selectedToppings[topping] ?? false,
                                onChanged: topping.isEnabled
                                    ? (bool? value) {
                                        if (value != null) {
                                          context.read<PizzaBloc>().add(
                                                UpdateSelectedTopping(
                                                    topping, value),
                                              );
                                        }
                                      }
                                    : null,
                              ),
                              Text(
                                topping.name,
                                style:
                                    AppTextStyle.regular.copyWith(fontSize: 14),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Harga
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: AppTextStyle.regular.copyWith(fontSize: 14),
                          ),
                          Text(
                            '\$${_calculateTotalPrice(state)}',
                            style: AppTextStyle.regular.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Container _selectedPizaa({
    required String name,
    required String price,
    required String value,
    required String groupValue,
    void Function(String?)? onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ColumnPadding(
        crossAxisAlignment: CrossAxisAlignment.center,
        padding: const EdgeInsets.all(10),
        children: [
          const CustomImageWrapper(
            image: AppImageAssets.pizza,
            isNetworkImage: false,
          ),
          const Gap(height: 10),
          Text(name),
          Text(
            'Made In Indonesia',
            style: AppTextStyle.medium.copyWith(
              color: Colors.grey,
              fontSize: AppFontSize.small,
            ),
          ),
          Text.rich(TextSpan(
            text: '\$',
            style: AppTextStyle.semiBold.copyWith(
              color: Colors.red[600],
              fontSize: 12,
            ),
            children: [
              TextSpan(
                text: price,
                style: AppTextStyle.regular.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
              )
            ],
          )),
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }

  double _calculateTotalPrice(PizzaLoaded state) {
    double pizzaPrice = state.pizzas
        .firstWhere((pizza) => pizza.name == state.selectedPizza)
        .price
        .toDouble();
    double sizePrice = state.sizes
        .firstWhere((size) => size.size == state.selectedSize)
        .price
        .toDouble();
    double toppingPrice = state.selectedToppings.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key.price)
        .fold(0.0, (prev, price) => prev + price);

    return pizzaPrice + sizePrice + toppingPrice;
  }
}
