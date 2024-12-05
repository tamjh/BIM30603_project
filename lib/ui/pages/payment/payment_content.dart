import 'package:flutter/material.dart';
import 'package:project/ui/shared/size_fit.dart';

class PaymentContent extends StatefulWidget {
  const PaymentContent({super.key});

  @override
  State<PaymentContent> createState() => _PaymentContentState();
}

class _PaymentContentState extends State<PaymentContent> {
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expDate = TextEditingController();
  TextEditingController cvv = TextEditingController();
  String selectedMethod = "Debit Card/Credit Card";

  final Map<String, Widget> paymentMethods = {
    "FPX": Icon(Icons.payment),
    "Debit Card/Credit Card": Icon(Icons.credit_card),
    "Touch n Go": Icon(Icons.account_balance_wallet),
  };

  @override
  void dispose() {
    cardNumber.dispose();
    expDate.dispose();
    cvv.dispose();
    super.dispose();
  }

  @override
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSubTitle(context, "Shipping Information"),
          SizedBox(height: 20.px),
          buildShippingInfo(context),
          SizedBox(height: 20.px),
          buildMethod(context),
          SizedBox(height: 20.px),
          if (selectedMethod == "Debit Card/Credit Card") buildCard(context),
          if (selectedMethod == "Touch n Go") buildEwallet(context),
        ],
      ),
    ),
    bottomNavigationBar: Column(
      mainAxisSize: MainAxisSize.min, // Ensure column adjusts to content
      children: [
        // Price Summary Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order:",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  Text("RM 123.00", style: TextStyle(fontSize: 32.px),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery:",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  Text("RM 12.00", style: TextStyle(fontSize: 32.px)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Text("RM 135.00", style: TextStyle(fontSize: 32.px)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.px), // Spacing between price and button

        // Pay Button
        buildButton(context),
      ],
    ),
  );
}


  Padding buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 16.0)),
          ),
          child: Text(
            "Pay",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 32.px, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildSubTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style:
            Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40.px),
      ),
    );
  }

  Widget buildShippingInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 30.px),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "John Doe",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 40.px),
              ),
              GestureDetector(
                onTap: () {
                  print("GOTO change");
                },
                child: Text(
                  "Change",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.red,
                        fontSize: 30.px,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32.px),
          Text(
            "34, jalan manis 10, taman manis 2, 81200, batu pahat, johor",
            style: TextStyle(fontSize: 30.px),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            controller: cardNumber,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Card Number"),
              hintText: "1234 1234 1234",
            ),
          ),
          SizedBox(height: 20.px),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: expDate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Expire Date"),
                    hintText: "MM / YY",
                  ),
                ),
              ),
              SizedBox(width: 20.px),
              Expanded(
                child: TextFormField(
                  controller: cvv,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("CVV"),
                    hintText: "789",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMethod(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSubTitle(context, "Select Payment Method"),
        SizedBox(height: 20.px),
        DropdownButtonFormField<String>(
          value: selectedMethod,
          items: paymentMethods.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    entry.value,
                    SizedBox(width: 10),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(entry.key, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedMethod = newValue!;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Payment Method",
          ),
        ),
      ],
    );
  }

  Widget buildEwallet(BuildContext context) {
    TextEditingController phone = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: phone,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Phone Number"),
          hintText: "(+60)xxxxxxxxxxx",
        ),
      ),
    );
  }
}
