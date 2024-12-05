import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/ui/shared/size_fit.dart';

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
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Number OD9999${index}",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        "22-04-2003",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: const Color.fromARGB(255, 103, 103, 103)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                ?.copyWith(color: Colors.grey),
                          ),
                          Text("${index + 1}",
                              style: Theme.of(context).textTheme.displayMedium)
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Total Amount: ",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                          Text("RM 123.45",
                              style: Theme.of(context).textTheme.displayMedium)
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                          onPressed: () {},
                          child: Text(
                            "Detail",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(color: Colors.white, fontSize: 50.px),
                          )),
                          Text("Complete", style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.green),)
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
