import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/constant/app_colors.dart';
import 'package:flutter_bloc_template/screens/base_screen/terms_and_conditions_screen/cubit/terms_and_conditions_cubit.dart';
import 'package:flutter_bloc_template/screens/base_screen/terms_and_conditions_screen/cubit/terms_and_conditions_state.dart';
import 'package:flutter_bloc_template/screens/base_screen/widgets/base_data_widget.dart';
import 'package:flutter_bloc_template/screens/base_screen/widgets/base_no_found_data_widget.dart';
import 'package:flutter_bloc_template/utils/app_size.dart';
import 'package:flutter_bloc_template/widgets/texts/app_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TermsAndConditionsCubit(),
      child: const _TermsAndConditionsView(),
    );
  }
}

class _TermsAndConditionsView extends StatelessWidget {
  const _TermsAndConditionsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.white400,
      appBar: AppBar(
        centerTitle: true,
        title: const AppText(text: "Terms & Conditions", fontWeight: FontWeight.w600),
        elevation: 2,
        shadowColor: AppColors.instance.dark300,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(
            bottomLeft: Radius.circular(AppSize.width(value: 40)),
            bottomRight: Radius.circular(AppSize.width(value: 40)),
          ),
        ),
      ),
      body: BlocBuilder<TermsAndConditionsCubit, TermsAndConditionsState>(
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
