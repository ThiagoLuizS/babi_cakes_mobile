import 'package:babi_cakes_mobile/src/constants/sizes.dart';
import 'package:babi_cakes_mobile/src/constants/text_strings.dart';
import 'package:babi_cakes_mobile/src/constants/variables.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/profile/profile_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/address_form.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/address/profile_address_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/profile_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAddressFormScreen extends StatefulWidget {
  const ProfileAddressFormScreen({Key? key}) : super(key: key);

  @override
  State<ProfileAddressFormScreen> createState() =>
      _ProfileAddressFormScreenState();
}

class _ProfileAddressFormScreenState extends State<ProfileAddressFormScreen> {
  late AddressForm addressForm;
  final _blocAddress = ProfileBloc();
  late bool isLoading = false;
  late bool isLoadingSave = false;
  late bool isShowForm = false;

  final _cepController = TextEditingController();
  final _typeController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _districtController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _complementController = TextEditingController();

  final _formGetCepKey = GlobalKey<FormState>();
  final _formSaveKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _blocAddress.dispose();
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    isLoadingSave = false;
    isShowForm = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => Get.offAll(() => const ProfileAddressScreen()),
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
          title: "Cadastro de Endereço",
        ),
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: height,
              padding: tPageWithTopIconPadding,
              child: Form(
                key: _formSaveKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formGetCepKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (String? value) {
                                if (value != null && value.isEmpty) {
                                  return 'Informe um CEP';
                                }
                                return null;
                              },
                              controller: _cepController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text("Informe o CEP"),
                                prefixIcon: Icon(Icons.person_outline_rounded),
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 25),
                            !isLoading
                                ? SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.greyTransp200,
                                        side: const BorderSide(
                                            width: 0, color: Colors.white),
                                      ),
                                      onPressed: () {
                                        if (_formGetCepKey.currentState!
                                            .validate()) {
                                          _getAddressByCep(_cepController.text);
                                        }
                                      },
                                      child: const Text(
                                        "Buscar",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(
                                        color: AppColors.berimbau),
                                  ),
                          ],
                        ),
                      ),
                      isShowForm
                          ? Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Column(
                                children: [
                                  TextFormField(
                                    enabled: false,
                                    controller: _typeController,
                                    decoration: const InputDecoration(
                                        label: Text("Tipo"),
                                        prefixIcon:
                                            Icon(Icons.horizontal_distribute)),
                                  ),
                                  const SizedBox(height: tFormHeight - 20),
                                  TextFormField(
                                    enabled: false,
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                        label: Text("Endereço"),
                                        prefixIcon:
                                            Icon(Icons.location_on_outlined)),
                                  ),
                                  const SizedBox(height: tFormHeight - 20),
                                  TextFormField(
                                    validator: (String? value) {
                                      if (value != null && value.isEmpty) {
                                        return 'Informe um número';
                                      }
                                      return null;
                                    },
                                    controller: _numberController,
                                    decoration: const InputDecoration(
                                        label: Text("Número"),
                                        prefixIcon: Icon(Icons.numbers_outlined)),
                                  ),
                                  const SizedBox(height: tFormHeight - 20),
                                  TextFormField(
                                    controller: _complementController,
                                    decoration: const InputDecoration(
                                        label: Text("Complemento"),
                                        prefixIcon: Icon(Icons.comment_bank_outlined)),
                                  ),
                                  const SizedBox(height: tFormHeight - 20),
                                  TextFormField(
                                    enabled: false,
                                    controller: _districtController,
                                    decoration: const InputDecoration(
                                        label: Text("Bairro"),
                                        prefixIcon: Icon(Icons.vertical_distribute)),
                                  ),
                                  const SizedBox(height: tFormHeight - 20),
                                  TextFormField(
                                    enabled: false,
                                    controller: _cityController,
                                    decoration: const InputDecoration(
                                        label: Text("Cidade"),
                                        prefixIcon: Icon(Icons.share_location_outlined)),
                                  ),
                                  const SizedBox(height: tFormHeight - 20),
                                  TextFormField(
                                    enabled: false,
                                    controller: _stateController,
                                    decoration: const InputDecoration(
                                        label: Text("Estado"),
                                        prefixIcon: Icon(Icons.location_searching_outlined)),
                                  ),
                                  const SizedBox(height: tFormHeight - 10),
                                  !isLoading ? SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formSaveKey.currentState!
                                            .validate()) {
                                          _saveAddress();
                                        }
                                      },
                                      child: Text(tSignup.toUpperCase()),
                                    ),
                                  ) : const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(
                                        color: AppColors.berimbau),
                                  ),
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getAddressByCep(String cep) async {
    setState(() {
      isLoading = true;
    });

    ApiResponse<AddressForm> response = await _blocAddress.getAddressByCep(cep);

    if (response.ok) {
      setState(() {
        addressForm = response.result;
        isLoading = false;
        isShowForm = true;

        _cepController.text = response.result.cep.toString();
        _typeController.text = response.result.addressType;
        _nameController.text = response.result.addressName;
        _numberController.text = response.result.number;
        _districtController.text = response.result.district;
        _cityController.text = response.result.city;
        _stateController.text = response.result.state;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      alertToast(context, response.erros[0].toString(), 3, Colors.grey, false);
    }
  }

  _saveAddress() async {
    setState(() {
      isLoadingSave = true;
    });

    addressForm.number = _numberController.text;
    addressForm.complement = _complementController.text;

    ApiResponse<Object> response = await _blocAddress.saveAddress(addressForm);

    if (!response.ok) {
      alertToast(context, response.erros[0].toString(), 3, AppColors.milkCream, false);
    } else {
      Get.offAll(() => const ProfileAddressScreen());
    }

    setState(() {
      isLoadingSave = false;
    });
  }
}
