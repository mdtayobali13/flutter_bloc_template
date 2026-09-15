import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/screens/base_screen/faq_screen/cubit/faq_cubit.dart';
import 'package:flutter_bloc_template/screens/base_screen/faq_screen/cubit/faq_state.dart';
import 'package:flutter_bloc_template/screens/base_screen/faq_screen/widgets/faq_card.dart';
import 'package:flutter_bloc_template/screens/base_screen/faq_screen/widgets/faq_card_loader.dart';
import 'package:flutter_bloc_template/utils/app_size.dart';
import 'package:flutter_bloc_template/widgets/texts/app_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FaqCubit(),
      child: const _FaqView(),
    );
  }
}

class _FaqView extends StatelessWidget {
  const _FaqView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppText(text: "FAQ", fontWeight: FontWeight.w500),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSize.size.width * 0.05),
        child: BlocBuilder<FaqCubit, FaqState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Skeletonizer(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => const FaqCardLoader(),
                ),
              );
            }

            if (state.isError) {
              return Center(child: AppText(text: state.errorMessage ?? "Something Was Wrong"));
            }

            final data = state.data;
            if (data.isEmpty) return const SizedBox();

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return FaqCard(
                  item: item,
                  onTap: () {
                    context.read<FaqCubit>().changeItem(index);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
