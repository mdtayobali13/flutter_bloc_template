import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/constant/app_colors.dart';
import 'package:flutter_bloc_template/constant/app_constant.dart';
import 'package:flutter_bloc_template/utils/language/language_data.dart';
import 'package:flutter_bloc_template/widgets/texts/languages/language_cubit.dart';
import 'package:flutter_bloc_template/widgets/texts/languages/translation_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.textScaleFactor = 0.9,
    this.color,
    this.fontWeight = FontWeight.w400,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.height,
    this.decoration,
    this.isDynamic = false,
    this.decorationColor,
    this.fontFamily,
    this.style,
  });

  final String text;
  final double? fontSize;
  final double textScaleFactor;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? height;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final bool isDynamic;
  final String? fontFamily;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = context.select((LanguageCubit c) => c.state);

    final textStyle =
        style?.copyWith(fontFamily: fontFamily ?? AppConstant.instance.fontFamilyPoppins) ??
        Theme.of(context).textTheme.displaySmall?.copyWith(
          height: height,
          fontSize: fontSize,
          color: color ?? AppColors.instance.black500,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? AppConstant.instance.fontFamilyPoppins,
          decoration: decoration,
          decorationColor: decorationColor,
        );

    if (!isDynamic) {
      final languageMap = LanguageData.getLanguage(selectedLanguage);

      final value = languageMap[text] ?? text;

      return _buildText(value, textStyle);
    }

    return FutureBuilder<String>(
      key: ValueKey('${text}_$selectedLanguage'),
      future: TranslationService.instance.getText(key: text, language: selectedLanguage),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Skeletonizer(enabled: true, child: _buildText(text, textStyle));
        }
        final value = snapshot.data ?? text;

        return _buildText(value, textStyle);
      },
    );
  }

  Widget _buildText(String value, TextStyle? style) {
    return Text(
      value,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign,
      style: style,
      textScaler: TextScaler.linear(textScaleFactor),
    );
  }
}
