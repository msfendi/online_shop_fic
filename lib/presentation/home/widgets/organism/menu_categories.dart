import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/category/category_bloc.dart';
import '../category_button.dart';

class MenuCategories extends StatefulWidget {
  const MenuCategories({super.key});

  @override
  State<MenuCategories> createState() => _MenuCategoriesState();
}

class _MenuCategoriesState extends State<MenuCategories> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<CategoryBloc>().add(const CategoryEvent.getCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return state.maybeWhen(
            loaded: ((categories) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...categories.map((category) => Flexible(
                          child: CategoryButton(
                            imagePath: category.image!,
                            label: category.name!,
                            onPressed: () {},
                          ),
                        ))
                  ],
                )),
            orElse: () => const SizedBox.shrink(),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            error: (message) => Center(
                  child: Text(message),
                ));
      },
    );
  }
}
