import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irfanxtest/constants/color_constants.dart';

import '../../../widgets/custom_text_widget.dart';
import '../utility/shopping_cart_utility.dart';

class ShoppingCartView extends StatefulWidget {
  const ShoppingCartView({super.key});

  @override
  State<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {

  String total = "1 item(s) - SAR 36.80";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          text: "Shopping cart",
          textFontWeight: FontWeight.bold,
          textFontSize: 20,
        ),
        centerTitle: true,
        actions: const [
          Icon(
            CupertinoIcons.arrow_down_circle
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: total,
                textColor: ApplicationColorConstants.blackColor,
                textFontSize: 20,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ApplicationColorConstants.blackColor,
                    ),
                    onPressed: () {

                    },
                    child: CustomTextWidget(
                      text: "Checkout",
                      textColor: ApplicationColorConstants.whiteColor,
                    )
                  ),
                ),
              ),
              BottomNavigationBar(
                currentIndex: 3,
                unselectedItemColor: ApplicationColorConstants.greyColor,
                selectedItemColor: ApplicationColorConstants.blackColor,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                    ),
                    label: "Home"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.category,
                      ),
                      label: "Categories"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.branding_watermark,
                      ),
                      label: "Brands"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_bag,
                      ),
                      label: "Bag",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_box,
                    ),
                    label: "My Account",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: ShoppingCartUtility().getShoppingCartData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case (ConnectionState.waiting):
              return const Center(
                child: CustomTextWidget(
                  text: "Please wait while the data is being loaded",
                ),
              );
            case (ConnectionState.active):
              return const Center(
                child: CustomTextWidget(
                  text: "Please wait while the data is being loaded",
                ),
              );
            case (ConnectionState.none):
              return const Center(
                child: CustomTextWidget(
                  text: "Sorry it seems that the data does not exists",
                ),
              );
            case (ConnectionState.done):
              if (snapshot.hasError) {
                return const Center(
                  child: CustomTextWidget(
                    text: "Sorry, it seems that an unexpected error has occured",
                  ),
                );
              }
              print(snapshot.data);
              total = snapshot.data['cart']['total'];
              return ListView(
                children: [
                  for (Map<String, dynamic> product in snapshot.data['cart']['products'])...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10
                      ),
                      child: Card(
                        elevation: 3,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      product['thumb']
                                    ),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomTextWidget(
                                        text: product['manufacturer_name'],
                                        textColor: ApplicationColorConstants.greyColor,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 2.5,
                                            child: CustomTextWidget(
                                              text: "${product['name']} - ${product['quantity']} Piece",
                                              textColor: ApplicationColorConstants.blackColor,
                                              textFontSize: 13,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.delete,
                                            color: ApplicationColorConstants.blackColor,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomTextWidget(
                                                text: product['special'][0]['original_price'],
                                                textColor: ApplicationColorConstants.greyColor,
                                                textFontSize: 8,
                                              ),
                                              CustomTextWidget(
                                                text: product['special'][0]['price_formated'],
                                                textColor: ApplicationColorConstants.redColor,
                                                textFontSize: 10,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                color: ApplicationColorConstants.greyColor
                                              )
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomTextWidget(
                                                    text: "-",
                                                    textFontSize: 14,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomTextWidget(
                                                    text: "1",
                                                    textFontSize: 14,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomTextWidget(
                                                    text: "+",
                                                    textFontSize: 14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20
                    ),
                    child: CustomTextWidget(
                      text: "Products you may like",
                      textFontWeight: FontWeight.bold,
                      textFontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 4
                      ),
                      children: [
                        for (Map<String, dynamic> product in snapshot.data['recommended_products'] ['products'])...[
                          Card(
                            elevation: 3,
                            child: Container(
                              width: 100,
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            product['thumb']
                                          )
                                        )
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 2.5,
                                      child: CustomTextWidget(
                                        text: "${product['name']} - ${product['quantity']} Piece",
                                        textColor: ApplicationColorConstants.blackColor,
                                        textFontSize: 12,
                                        textOverflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    CustomTextWidget(
                                      text: product['price_formated'],
                                      textColor: ApplicationColorConstants.redColor,
                                      textFontSize: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  )
                ],
              );
            case ConnectionState.none:
              // TODO: Handle this case.
          }
          return Container();
        }
      ),
    );
  }
}
