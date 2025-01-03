import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/model/order_model.dart';
import 'package:project/core/viewmodel/order_view_model.dart';
import 'package:project/core/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class OrderHistoryContent extends StatefulWidget {
  const OrderHistoryContent({super.key});

  @override
  State<OrderHistoryContent> createState() => _OrderHistoryContentState();
}

class _OrderHistoryContentState extends State<OrderHistoryContent> {
  String? uid;

  @override
  Widget build(BuildContext context) {
    // Get the user ID
    uid = Provider.of<UserViewModel>(context).currentUser?.uid;

    return FutureBuilder<List<OrderItem>>(
      future: Provider.of<OrderViewModel>(context, listen: false)
          .getOrders(uid!), // Call getOrders and await its result
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
                  CircularProgressIndicator()); // Show loading spinner while waiting
        } else if (snapshot.hasError) {
          return Center(
              child: Text("Error: ${snapshot.error}")); // Show error if any
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text("No orders found")); // Show message if no data
        } else {
          List<OrderItem> _item =
              snapshot.data!; // Use the data returned from the Future

          return ListView(
            children: _item.map((order) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 40.0.h, horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                width: 220.w,
                                child: Text(
                                  "Order 00${_item.length - _item.indexOf(order)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                          color: Colors.black, fontSize: 20.sp),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${order.created_at.day}-${order.created_at.month}-${order.created_at.year}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        color: const Color.fromARGB(
                                            255, 103, 103, 103)),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Quantity: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                          color: Colors.grey, fontSize: 15.sp),
                                ),
                                Text("${order.items.length}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(fontSize: 20.sp))
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Total Amount: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                          color: Colors.grey, fontSize: 15.sp),
                                ),
                                Text(
                                    "RM ${order.totalPrice.toStringAsFixed(2)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(fontSize: 20.sp))
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Container(
                                          width: 0.8.sw,
                                          constraints: BoxConstraints(
                                            maxHeight: 0.7.sh,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Text(
                                                  "Order Details",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                ),
                                              ),
                                              Flexible(
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: order.items.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final item =
                                                        order.items[index];
                                                    return Card(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16.0,
                                                              vertical: 8.0),
                                                      elevation: 2.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: ListTile(
                                                        title: Text(
                                                          item['product']
                                                              ['name'],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayMedium
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16.sp,
                                                                  ),
                                                        ),
                                                        subtitle: Text(
                                                          "RM ${item['product']['price']}",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium,
                                                        ),
                                                        trailing: Text(
                                                          "Qty: ${item['quantity']}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displaySmall
                                                                  ?.copyWith(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: Text(
                                                    "Close",
                                                    style: TextStyle(
                                                        fontSize: 25.sp,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Detail",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                          color: Colors.white, fontSize: 25.sp),
                                )),
                            Text(
                              "Pending",
                              // You can adjust this status dynamically based on order state
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(color: Colors.red),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
