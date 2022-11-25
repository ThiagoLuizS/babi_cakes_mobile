import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:flutter/material.dart';

class SearchProductComponent extends StatefulWidget {
  final TextEditingController filterController;
  late ProductBloc productBloc;
  late Function onPressed;

  SearchProductComponent({
    Key? key,
    required this.filterController,
    required this.productBloc,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<SearchProductComponent> createState() => _SearchProductComponentState();
}

class _SearchProductComponentState extends State<SearchProductComponent> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: Colors.grey.shade100,
                ),
                child: TextFormField(
                  controller: widget.filterController,
                  decoration: const InputDecoration(
                    hintText: 'Nome do produto',
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
