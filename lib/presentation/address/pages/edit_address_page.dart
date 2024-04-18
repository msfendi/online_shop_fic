import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_shop_fic/data/models/responses/address_response_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_dropdown.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../data/models/responses/city_response_model.dart';
import '../../../data/models/responses/province_response_model.dart';
import '../../../data/models/responses/subdistrict_response_model.dart';
import '../bloc/city/city_bloc.dart';
import '../bloc/edit_address/edit_address_bloc.dart';
import '../bloc/province/province_bloc.dart';
import '../bloc/subdistrict/subdistrict_bloc.dart';

class EditAddressPage extends StatefulWidget {
  final Address data;
  const EditAddressPage({super.key, required this.data});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  @override
  void initState() {
    // TODO: implement initState
    context
        .read<EditAddressBloc>()
        .add(EditAddressEvent.addProvinceId(widget.data.provId!));
    context
        .read<EditAddressBloc>()
        .add(EditAddressEvent.addCityId(widget.data.cityId!));
    context
        .read<EditAddressBloc>()
        .add(EditAddressEvent.addDistrictId(widget.data.districtId!));
    context.read<ProvinceBloc>().add(const ProvinceEvent.getProvince());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController(text: widget.data.name);
    final addressController =
        TextEditingController(text: widget.data.fullAddress);
    final zipCodeController =
        TextEditingController(text: widget.data.postalCode);
    final phoneNumberController =
        TextEditingController(text: widget.data.phone);

    Province selectedProvince = Province(
      provinceId: widget.data.provId,
      province: '',
    );

    City selectedCity = City(
      cityId: widget.data.cityId,
      provinceId: widget.data.provId,
      province: '',
    );

    Subdistrict selectedSubdistrict = Subdistrict(
      subdistrictId: widget.data.districtId,
      provinceId: widget.data.provId,
      province: '',
      cityId: widget.data.cityId,
      city: '',
      subdistrictName: '',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Adress'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // ValueListenableBuilder(
          //   valueListenable: countryNotifier,
          //   builder: (context, value, _) => CustomDropdown(
          //     value: value!.toString(),
          //     items: country,
          //     label: 'Negara atau wilayah',
          //     onChanged: (value) => countryNotifier.value = value ?? '',
          //   ),
          // ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: firstNameController,
            label: 'Nama Depan',
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: addressController,
            label: 'Alamat jalan',
          ),
          const SpaceHeight(24.0),
          BlocBuilder<ProvinceBloc, ProvinceState>(
            builder: (context, state) {
              return state.maybeWhen(
                  orElse: () => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: CustomDropdown(
                          value: selectedProvince,
                          items: const [],
                          label: 'Provinsi')),
                  loaded: (provinces) {
                    // select the province based on widget.data.provId
                    // context
                    //     .read<CityBloc>()
                    //     .add(CityEvent.getCity(widget.data.provId!));
                    selectedProvince = provinces.firstWhere((element) =>
                        element.provinceId == selectedProvince.provinceId);
                    return BlocBuilder<EditAddressBloc, EditAddressState>(
                      builder: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          loaded: (provinceId, _, __) {
                            selectedProvince.provinceId = provinceId;
                            context.read<CityBloc>().add(CityEvent.getCity(
                                  provinceId,
                                ));
                          },
                        );
                        return CustomDropdown<Province>(
                            value: selectedProvince,
                            items: provinces,
                            label: 'Provinsi',
                            onChanged: (value) {
                              context.read<EditAddressBloc>().add(
                                  EditAddressEvent.addProvinceId(
                                      value!.provinceId!));
                            });
                      },
                    );
                  });
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: (() {
                  context
                      .read<CityBloc>()
                      .add(CityEvent.getCity(selectedProvince.provinceId!));
                  return const Center(child: CircularProgressIndicator());
                }),
                orElse: () => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: CustomDropdown(
                        value: selectedCity, items: const [], label: 'Kota')),
                loaded: (cities) {
                  if (selectedCity.cityId != widget.data.cityId) {
                    selectedCity = cities.first;
                  } else {
                    selectedCity = cities.firstWhere(
                        (element) => element.cityId == selectedCity.cityId);
                  }
                  return BlocBuilder<EditAddressBloc, EditAddressState>(
                    builder: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        loaded: (_, cityId, __) {
                          selectedCity.cityId = cityId;
                          context.read<SubdistrictBloc>().add(
                              SubdistrictEvent.getSubdistrict(
                                  selectedCity.cityId!));
                        },
                      );
                      return CustomDropdown<City>(
                        value: selectedCity,
                        items: cities,
                        label: 'Kota',
                        onChanged: (value) {
                          context
                              .read<EditAddressBloc>()
                              .add(EditAddressEvent.addCityId(value!.cityId!));
                          selectedSubdistrict.subdistrictId = '';
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<SubdistrictBloc, SubdistrictState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: CustomDropdown(
                        value: selectedSubdistrict,
                        items: const [],
                        label: 'Kecamatan')),
                loaded: (subdistricts) {
                  selectedSubdistrict = subdistricts.firstWhere((element) =>
                      element.subdistrictId ==
                      selectedSubdistrict.subdistrictId);
                  return BlocBuilder<EditAddressBloc, EditAddressState>(
                    builder: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        loaded: (_, __, districtId) {
                          selectedSubdistrict.subdistrictId = districtId;
                        },
                      );
                      return CustomDropdown<Subdistrict>(
                        value: selectedSubdistrict,
                        items: subdistricts,
                        label: 'Kecamatan',
                        onChanged: (value) {
                          context.read<EditAddressBloc>().add(
                              EditAddressEvent.addDistrictId(
                                  value!.subdistrictId!));
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: zipCodeController,
            label: 'Kode Pos',
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: phoneNumberController,
            label: 'No Handphone',
          ),
          const SpaceHeight(24.0),
          Button.filled(
            onPressed: () {
              context.pop();
            },
            label: 'Perbarui Alamat',
          ),
        ],
      ),
    );
  }
}
