import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_shop_fic/data/models/requests/address_request_model.dart';
import 'package:online_shop_fic/data/models/responses/subdistrict_response_model.dart';
import 'package:online_shop_fic/presentation/address/bloc/add_address/add_address_bloc.dart';
import 'package:online_shop_fic/presentation/address/bloc/city/city_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_dropdown.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/router/app_router.dart';
import '../../../data/models/responses/city_response_model.dart';
import '../../../data/models/responses/province_response_model.dart';
import '../bloc/province/province_bloc.dart';
import '../bloc/subdistrict/subdistrict_bloc.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final firstNameController = TextEditingController();
  // final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();

  Province selectedProvince = Province(
    provinceId: '',
    province: '',
  );

  City selectedCity = City(
    cityId: '',
    provinceId: '',
    province: '',
    type: '',
    cityName: '',
    postalCode: '',
  );

  Subdistrict selectedSubdistrict = Subdistrict(
    subdistrictId: '',
    provinceId: '',
    province: '',
    cityId: '',
    city: '',
    type: '',
    subdistrictName: '',
  );

  @override
  void initState() {
    // ketika page ini dijalankan, maka akan memanggil event getProvince dari bloc
    context.read<ProvinceBloc>().add(const ProvinceEvent.getProvince());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Adress'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          CustomTextField(
            controller: firstNameController,
            label: 'Nama Lengkap',
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: addressController,
            label: 'Alamat jalan',
          ),
          const SpaceHeight(24.0),

          // digunakan untuk menampilkan data provinsi yang diambil dari server
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
                    // selectedProvince = provinces.first;
                    return CustomDropdown<Province>(
                        value: provinces.first,
                        items: provinces,
                        label: 'Provinsi',
                        onChanged: (value) {
                          setState(() {
                            selectedProvince = value!;
                            // ketika provinsi dipilih, maka akan memanggil event getCity dari bloc
                            context.read<CityBloc>().add(CityEvent.getCity(
                                selectedProvince.provinceId!));
                          });
                        });
                  });
            },
          ),
          const SpaceHeight(24.0),
          // digunakan untuk menampilkan data kota yang diambil dari server
          BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: CustomDropdown(
                        value: selectedCity, items: const [], label: 'Kota')),
                loaded: (cities) {
                  return CustomDropdown<City>(
                    value: cities.first,
                    items: cities,
                    label: 'Kota',
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value!;
                        // ketika kota dipilih, maka akan memanggil event getSubdistrict dari bloc
                        context.read<SubdistrictBloc>().add(
                            SubdistrictEvent.getSubdistrict(
                                selectedCity.cityId!));
                      });
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          // digunakan untuk menampilkan data kecamatan yang diambil dari server
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
                  return CustomDropdown<Subdistrict>(
                    value: subdistricts.first,
                    items: subdistricts,
                    label: 'Kecamatan',
                    onChanged: (value) {
                      setState(() {
                        selectedSubdistrict = value!;
                      });
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
          BlocConsumer<AddAddressBloc, AddAddressState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: () {
                  context.goNamed(
                    RouteConstants.address,
                    pathParameters: PathParameters(
                      rootTab: RootTab.order,
                    ).toMap(),
                  );
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return Button.filled(
                  onPressed: () {
                    context
                        .read<AddAddressBloc>()
                        .add(AddAddressEvent.addAddress(
                            addressRequest: AddressRequest(
                          name: firstNameController.text,
                          fullAddress: addressController.text,
                          provId: selectedProvince.provinceId!,
                          cityId: selectedCity.cityId!,
                          districtId: selectedSubdistrict.subdistrictId!,
                          postalCode: zipCodeController.text,
                          phone: phoneNumberController.text,
                          isDefault: false,
                        )));
                  },
                  label: 'Tambah Alamat',
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, error: (message) {
                return Center(
                  child: Text(message),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
