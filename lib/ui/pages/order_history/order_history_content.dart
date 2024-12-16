import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistoryContent extends StatelessWidget {
  const OrderHistoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 40.0.h, horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 220.w,
                        child: Text(
                          "Order Number OD9999${index}",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(color: Colors.black, fontSize: 20.sp),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "22-04-2003",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    color: const Color.fromARGB(
                                        255, 103, 103, 103)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
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
                                ?.copyWith(color: Colors.grey, fontSize: 15.sp),
                          ),
                          Text("${index + 1}",
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20.sp))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Total Amount: ",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: Colors.grey, fontSize: 15.sp),
                          ),
                          Text("RM 123.45",
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20.sp))
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Detail",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    color: Colors.white, fontSize: 25.sp),
                          )),
                      Text(
                        "Complete",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(color: Colors.green),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
