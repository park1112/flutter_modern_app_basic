import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find();
    final formKey = GlobalKey<FormBuilderState>();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primarySurface,
              AppColors.white,
              AppColors.accentSurface.withOpacity(0.3),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Custom App Bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '회원가입',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                    ),
                  ],
                ),
              ),

              // Step Indicator
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Obx(
                  () => _buildModernStepIndicator(
                    controller.currentStep.value,
                    ['기본 정보', '회사 정보', '약관 동의'],
                  ),
                ),
              ),

              // Form Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: keyboardHeight + padding.bottom + 100,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.grey200, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowMedium,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: FormBuilder(
                      key: formKey,
                      child: Obx(() {
                        switch (controller.currentStep.value) {
                          case 0:
                            return _buildBasicInfoStep(controller, context);
                          case 1:
                            return _buildCompanyInfoStep(controller, context);
                          case 2:
                            return _buildTermsStep(controller, context);
                          default:
                            return const SizedBox.shrink();
                        }
                      }),
                    ),
                  ),
                ),
              ),

              // Bottom Navigation
              Container(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 16,
                  bottom: padding.bottom + 24,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Obx(() {
                      if (controller.currentStep.value > 0) {
                        return Expanded(
                          child: OutlinedButton(
                            onPressed: controller.previousStep,
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(
                                color: AppColors.grey300,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              '이전',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    Obx(() {
                      if (controller.currentStep.value > 0) {
                        return const SizedBox(width: 16);
                      }
                      return const SizedBox.shrink();
                    }),
                    Expanded(
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  if (formKey.currentState?.saveAndValidate() ??
                                      false) {
                                    final formData =
                                        formKey.currentState!.value;
                                    controller.updateFormData(formData);

                                    if (controller.currentStep.value < 2) {
                                      controller.nextStep();
                                    } else {
                                      controller.register();
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  controller.currentStep.value < 2
                                      ? '다음'
                                      : '가입 완료',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernStepIndicator(int currentStep, List<String> steps) {
    return Row(
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          // Connector
          final isActive = index ~/ 2 < currentStep;
          return Expanded(
            child: Container(
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                gradient: isActive ? AppColors.primaryGradient : null,
                color: !isActive ? AppColors.grey200 : null,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          );
        } else {
          // Step
          final stepIndex = index ~/ 2;
          final isActive = stepIndex <= currentStep;
          final isCompleted = stepIndex < currentStep;

          return Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isActive ? AppColors.primaryGradient : null,
              color: !isActive ? AppColors.grey200 : null,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(
                      Icons.check_rounded,
                      color: AppColors.white,
                      size: 20,
                    )
                  : Text(
                      '${stepIndex + 1}',
                      style: TextStyle(
                        color: isActive ? AppColors.white : AppColors.grey600,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildBasicInfoStep(AuthController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '기본 정보 입력',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '계정 생성을 위한 기본 정보를 입력해주세요.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),

        FormBuilderTextField(
          name: 'email',
          decoration: InputDecoration(
            labelText: AppStrings.email,
            hintText: 'example@email.com',
            prefixIcon: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.email_outlined,
                size: 20,
                color: AppColors.grey600,
              ),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: AppStrings.fieldRequired),
            FormBuilderValidators.email(errorText: AppStrings.invalidEmail),
          ]),
        ),
        const SizedBox(height: 20),

        Obx(
          () => FormBuilderTextField(
            name: 'password',
            decoration: InputDecoration(
              labelText: AppStrings.password,
              hintText: '8자 이상 입력',
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.lock_outline_rounded,
                  size: 20,
                  color: AppColors.grey600,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.showPassword.value
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: AppColors.grey600,
                ),
                onPressed: controller.togglePasswordVisibility,
              ),
            ),
            obscureText: !controller.showPassword.value,
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: AppStrings.fieldRequired,
              ),
              FormBuilderValidators.minLength(
                8,
                errorText: AppStrings.passwordTooShort,
              ),
            ]),
          ),
        ),
        const SizedBox(height: 20),

        Obx(
          () => FormBuilderTextField(
            name: 'confirmPassword',
            decoration: InputDecoration(
              labelText: AppStrings.confirmPassword,
              hintText: '비밀번호 재입력',
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.lock_outline_rounded,
                  size: 20,
                  color: AppColors.grey600,
                ),
              ),
            ),
            obscureText: !controller.showPassword.value,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.fieldRequired;
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 20),

        FormBuilderTextField(
          name: 'name',
          decoration: InputDecoration(
            labelText: AppStrings.name,
            hintText: '이름 입력',
            prefixIcon: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.person_outline_rounded,
                size: 20,
                color: AppColors.grey600,
              ),
            ),
          ),
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: AppStrings.fieldRequired),
          ]),
        ),
        const SizedBox(height: 20),

        FormBuilderTextField(
          name: 'phoneNumber',
          decoration: InputDecoration(
            labelText: AppStrings.phoneNumber,
            hintText: '010-0000-0000',
            prefixIcon: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.phone_outlined,
                size: 20,
                color: AppColors.grey600,
              ),
            ),
          ),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: AppStrings.fieldRequired),
          ]),
        ),
      ],
    );
  }

  Widget _buildCompanyInfoStep(
    AuthController controller,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '회사 정보 입력',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '비즈니스 정보를 입력해주세요.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),

        FormBuilderTextField(
          name: 'companyName',
          decoration: InputDecoration(
            labelText: AppStrings.companyName,
            hintText: '회사명 입력',
            prefixIcon: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.business_outlined,
                size: 20,
                color: AppColors.grey600,
              ),
            ),
          ),
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: AppStrings.fieldRequired),
          ]),
        ),
        const SizedBox(height: 20),

        FormBuilderTextField(
          name: 'businessNumber',
          decoration: InputDecoration(
            labelText: AppStrings.businessNumber,
            hintText: '000-00-00000',
            prefixIcon: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.badge_outlined,
                size: 20,
                color: AppColors.grey600,
              ),
            ),
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: AppStrings.fieldRequired),
          ]),
        ),
        const SizedBox(height: 24),

        Text(
          '회원 유형',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),

        FormBuilderRadioGroup<String>(
          name: 'userType',
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          options: [
            FormBuilderFieldOption(
              value: 'supplier',
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.agriculture_rounded, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.supplier,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                          ),
                          Text(
                            '농산물을 공급하는 사업자',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FormBuilderFieldOption(
              value: 'buyer',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accentSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.accent.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_basket_rounded,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.buyer,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.accent,
                                ),
                          ),
                          Text(
                            '농산물을 구매하는 사업자',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          validator: FormBuilderValidators.required(
            errorText: AppStrings.fieldRequired,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsStep(AuthController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '이용약관 동의',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '서비스 이용을 위한 약관에 동의해주세요.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),

        Container(
          decoration: BoxDecoration(
            color: AppColors.grey50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.grey200, width: 1),
          ),
          child: Column(
            children: [
              Obx(
                () => InkWell(
                  onTap: () {
                    controller.setAgreeAll(!controller.agreeAll.value);
                  },
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: controller.agreeAll.value
                          ? AppColors.primarySurface
                          : null,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: controller.agreeAll.value
                                ? AppColors.primaryGradient
                                : null,
                            border: !controller.agreeAll.value
                                ? Border.all(color: AppColors.grey400, width: 2)
                                : null,
                          ),
                          child: controller.agreeAll.value
                              ? const Icon(
                                  Icons.check_rounded,
                                  size: 16,
                                  color: AppColors.white,
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '전체 동의',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: controller.agreeAll.value
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 1, color: AppColors.grey200),
              _buildTermItem(
                context,
                controller,
                '이용약관 동의',
                '(필수)',
                controller.agreeTerms,
                true,
              ),
              _buildTermItem(
                context,
                controller,
                '개인정보 처리방침 동의',
                '(필수)',
                controller.agreePrivacy,
                true,
              ),
              _buildTermItem(
                context,
                controller,
                '마케팅 정보 수신 동의',
                '(선택)',
                controller.agreeMarketing,
                false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTermItem(
    BuildContext context,
    AuthController controller,
    String title,
    String badge,
    RxBool value,
    bool isRequired,
  ) {
    return Obx(
      () => InkWell(
        onTap: () {
          value.value = !value.value;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: value.value ? AppColors.primary : AppColors.grey400,
                    width: 2,
                  ),
                  color: value.value ? AppColors.primary : Colors.transparent,
                ),
                child: value.value
                    ? const Icon(Icons.check, size: 14, color: AppColors.white)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isRequired
                            ? AppColors.errorSurface
                            : AppColors.grey100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        badge,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isRequired
                              ? AppColors.error
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.grey400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
