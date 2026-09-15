import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/constant/app_colors.dart';
import 'package:flutter_bloc_template/screens/base_screen/about_us_screen/cubit/about_us_cubit.dart';
import 'package:flutter_bloc_template/screens/base_screen/about_us_screen/cubit/about_us_state.dart';
import 'package:flutter_bloc_template/screens/base_screen/widgets/base_data_widget.dart';
import 'package:flutter_bloc_template/screens/base_screen/widgets/base_no_found_data_widget.dart';
import 'package:flutter_bloc_template/utils/app_size.dart';
import 'package:flutter_bloc_template/widgets/texts/app_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AboutUsCubit(),
      child: const _AboutUsView(),
    );
  }
}

class _AboutUsView extends StatelessWidget {
  const _AboutUsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.white400,
      appBar: AppBar(
        centerTitle: true,
        title: const AppText(text: "About Us", fontWeight: FontWeight.w600),
        elevation: 2,
        shadowColor: AppColors.instance.dark300,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(
            bottomLeft: Radius.circular(AppSize.width(value: 40)),
            bottomRight: Radius.circular(AppSize.width(value: 40)),
          ),
        ),
      ),
      body: BlocBuilder<AboutUsCubit, AboutUsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Skeletonizer(enabled: true, child: BaseNoFoundDataWidget());
          }
          if (state.isError || state.data.isEmpty) {
            return const BaseNoFoundDataWidget();
          }
          return BaseDataWidget(data: state.data);
        },
      ),
    );
  }
}
