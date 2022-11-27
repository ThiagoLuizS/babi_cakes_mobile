import 'package:babi_cakes_mobile/src/features/core/controllers/profile/profile_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/address_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/content_address.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shimmer_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/component/profile_address_card_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';

class ProfileAddressScreen extends StatefulWidget {
  const ProfileAddressScreen({Key? key}) : super(key: key);

  @override
  State<ProfileAddressScreen> createState() => _ProfileAddressScreenState();
}

class _ProfileAddressScreenState extends State<ProfileAddressScreen> {
  late ContentAddress contentAddress = ContentAddress(content: []);
  final _blocAddress = ProfileBloc();
  late bool isLoading = true;

  @override
  void dispose() {
    super.dispose();
    _blocAddress.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onGetProductAll();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.berimbau,
        ),
      ),
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarDefaultComponent(
          title: "Endereço",
        ),
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: height,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: height,
                        child: ListView.builder(
                          itemCount: contentAddress.content.length,
                          itemBuilder: (BuildContext itemBuilder, index) {
                            AddressView address = contentAddress.content[index];
                            return ShimmerComponent(
                              isLoading: isLoading,
                              child: ProfileAddressCardComponent(
                                onTapUpdateMain: () => _updateAddressMain(address.id),
                                addressView: address,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _onGetProductAll() async {
    setState(() {
      isLoading = true;
    });

    ApiResponse<ContentAddress> response =
        await _blocAddress.getAddressPageByUser();

    if (response.ok) {
      setState(() {
        contentAddress = response.result;
        isLoading = false;
      });
    }
  }

  _updateAddressMain(int id) async {

    ApiResponse<ContentAddress> response = await _blocAddress.updateAddressMain(id);

    if (response.ok) {
      _onGetProductAll();
    }
  }
}
