import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza/core/constants/app_colors.dart';
import 'package:laza/core/constants/app_strings.dart';
import 'package:laza/logic/blocs/home/home_bloc.dart';
import 'package:laza/presentation/widgets/bottom_button.dart';

class EditProductSheet extends StatefulWidget {
  const EditProductSheet({super.key, required this.productID});

  final int productID;

  @override
  _EditProductSheetState createState() => _EditProductSheetState();
}

class _EditProductSheetState extends State<EditProductSheet> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    _titleController.addListener(_validateFields);
    _priceController.addListener(_validateFields);
  }

  void _validateFields() {
    setState(() {
      _isButtonEnabled =
          _titleController.text.isNotEmpty && _priceController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomButton(
          onPressed: () {
            context.read<HomeBloc>().add(
                  EditProductEvent(productId: widget.productID, updatedData: {
                    "title": _titleController.text,
                    "price": _priceController.text,
                  }),
                );
          },
          title: AppStrings.update),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                const Text(
                  AppStrings.editProduct,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 24.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              AppStrings.title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: AppColors.borders,
                    )),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              AppStrings.price,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: AppColors.borders,
                    )),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
