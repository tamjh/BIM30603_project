import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class BuildAccountBox extends StatelessWidget {
  const BuildAccountBox({
    super.key,
    required String uid,
    required TextEditingController nameController,
    required TextEditingController phoneController,
  })  : _nameController = nameController,
        _phoneController = phoneController,
        _uid = uid; // Fix: initialize _uid correctly with passed value

  final TextEditingController _nameController;
  final TextEditingController _phoneController;
  final String _uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.w),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          BuildAccountEdit(
            label: "Full Name", 
            controller: _nameController,
            uid: _uid, // Pass UID to BuildAccountEdit
          ),
          const Divider(height: 20, color: Colors.grey, thickness: 1),
          BuildAccountEdit(
            label: "Phone Number", 
            controller: _phoneController,
            uid: _uid, // Pass UID to BuildAccountEdit
          ),
        ],
      ),
    );
  }
}

class BuildAccountEdit extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String uid; // Add UID to the widget

  const BuildAccountEdit({
    super.key,
    required this.label,
    required this.controller,
    required this.uid,
  });

  @override
  State<BuildAccountEdit> createState() => _BuildAccountEditState();
}

class _BuildAccountEditState extends State<BuildAccountEdit> {
  bool _displaySave = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, viewmodel, child) {
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
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 8.sp),
                TextField(
                  controller: widget.controller,
                  onChanged: (value) => setState(() {
                    _displaySave = value.isNotEmpty;
                  }),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
              ],
            ),
          ),
          if (_displaySave)
            GestureDetector(
                onTap: () {
                  setState(() {
                    _displaySave = false;
                  });
                },
                child: IconButton(
                  onPressed: () {
                    if (widget.label == "Full Name") {
                      viewmodel.updateName(widget.uid, widget.controller.text, context);
                      
                    } else if (widget.label == "Phone Number") {
                      viewmodel.updatePhone(widget.uid, widget.controller.text, context);
                    }
                    setState(() {
                    _displaySave = false;
                  });
                  },
                  icon: Icon(Icons.save, color: Colors.green, size: 30.sp),
                )),
        ],
      );
    });
  }
}
