import 'package:flutter/material.dart';
import 'package:project/ui/shared/size_fit.dart';

class BuildAccountBox extends StatelessWidget {
  const BuildAccountBox({
    super.key,
    required TextEditingController nameController,
    required TextEditingController phoneController,
  })  : _nameController = nameController,
        _phoneController = phoneController;

  final TextEditingController _nameController;
  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.px),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.px),
        borderRadius: BorderRadius.circular(10.px),
      ),
      child: Column(
        children: [
          BuildAccountEdit(label: "Full Name", controller: _nameController),
          const Divider(height: 20, color: Colors.grey, thickness: 1),
          BuildAccountEdit(label: "Phone Number", controller: _phoneController),
        ],
      ),
    );
  }
}

class BuildAccountEdit extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const BuildAccountEdit({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<BuildAccountEdit> createState() => _BuildAccountEditState();
}

class _BuildAccountEditState extends State<BuildAccountEdit> {
  bool _displaySave = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 32.px,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 8.px),
              TextField(
                controller: widget.controller,
                onChanged: (value) => setState(() {
                  _displaySave = value.isNotEmpty;
                }),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 8.px),
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 24.px,
                    ),
              ),
            ],
          ),
        ),
        if (_displaySave)
          GestureDetector(
            onTap: () {
              // Add save functionality here
              setState(() {
                _displaySave = false;
              });
            },
            child: IconButton(onPressed: (){}, icon: Icon(Icons.save, color: Colors.green, size: 50.px),)
          ),
        
      ],
    );
  }
}
