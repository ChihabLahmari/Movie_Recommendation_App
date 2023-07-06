import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_clean_architecture_mvvm/app/constants.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/app_strings.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/color_manager.dart';

import '../../resources/values_manager.dart';

enum StateRendererType {
  // POPUP STATES (dialog)  ::
  popupLoadingState,
  popupErrorState,
  popupSuccessState,

  // FULL SCREEN STATES (full screen) ::
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // GENERAL ::
  contentState,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryFunction;

  StateRenderer({super.key, 
    required this.stateRendererType,
    this.message = AppStrings.loading,
    this.title = Constants.empty,
    required this.retryFunction,
  });

  @override
  Widget build(BuildContext context) {
    return _getStatewidget(context);
  }

  _getStatewidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopUpDialog(
          [
            _getAnimateImage(JsonAssets.loading),
          ],
          context,
        );

      case StateRendererType.popupErrorState:
        return _getPopUpDialog(
          [
            _getAnimateImage(JsonAssets.error),
            _getMessage(message),
            _getRetryButton(AppStrings.ok, context)
          ],
          context,
        );

      case StateRendererType.popupSuccessState:
        return _getPopUpDialog(
          [
            _getAnimateImage(JsonAssets.success),
            _getMessage(message),
            _getRetryButton(AppStrings.ok, context),
          ],
          context,
        );
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([
          _getAnimateImage(JsonAssets.loading),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimateImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn([
          _getAnimateImage(JsonAssets.empty),
          _getMessage(message),
        ]);
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  // FUNCTIONS ::
  Widget _getAnimateImage(String animationImage) {
    return SizedBox(
      height: AppSize.s200,
      width: AppSize.s350,
      child: Lottie.asset(animationImage),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          textAlign: TextAlign.center,
          message,
          style: TextStyle(
            decoration: TextDecoration.none,
            color: ColorManager.red,
            fontSize: AppSize.s20,
          ),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(ColorManager.darkGrey),
            ),
            onPressed: () {
              if (stateRendererType == StateRendererType.fullScreenErrorState) {
                // call retry again function
                retryFunction.call();
              } else {
                // popup error state
                Navigator.of(context).pop();
              }
            },
            child: Text(
              buttonTitle,
            ),
          ),
        ),
      ),
    );
  }

  // POPUP ::
  Widget _getPopUpDialog(List<Widget> children, BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: ColorManager.transparent,
      child: Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
              ),
            ],
          ),
          child: _getDialogContent(children, context)),
    );
  }

  Widget _getDialogContent(List<Widget> children, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  // FULL ::
  Widget _getItemsColumn(List<Widget> children) {
    return Container(
      color: ColorManager.primary,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
