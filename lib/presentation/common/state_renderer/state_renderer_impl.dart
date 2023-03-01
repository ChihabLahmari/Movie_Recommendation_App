// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/app_strings.dart';

import '../../../app/constants.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

// loading state (POPUP, FULLSCREEN) ::
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({
    required this.stateRendererType,
    this.message = AppStrings.loading,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Error state (POPUP, FULLSCREEN) ::
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(
    this.stateRendererType,
    this.message,
  );

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Empty State ::
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

// content State ::
class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// trj3 UI المناسب for each state in FlowState
extension FlowStateExtendsion on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            // show loading popup (function trj3 dialog-popup) ::
            showPopup(context, getStateRendererType(), getMessage());
            // show content  ui of the screen (screen li tkon wra popup transprent)
            return contentScreenWidget;
          } else {
            // full screen loading state ::
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryFunction: retryFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            // show error popup (function trj3 dialog-popup)::
            showPopup(context, getStateRendererType(), getMessage());
            // show content  ui of the screen (screen li tkon wra popup transprent)
            return contentScreenWidget;
          } else {
            // full screen error state  ::
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryFunction: retryFunction,
            );
          }
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryFunction: () {},
          );
        }

      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  // nchfo ida ay kayna dialog-popup rahi active wla no
  // bah ida kayna mndirouch fo-ha popup w7da 5ra n9floha omb3d ndiro
  // example : in case loadingstate and error happend we don't puch popup of error...
  //...above the popup of the loading we close loading popup first
  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  // function to close the first popup to show another popup
  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context) == true) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  // function trj3 popup-dialog above the Screen
  showPopup(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          retryFunction: () {},
        ),
      ),
    );
  }
}
