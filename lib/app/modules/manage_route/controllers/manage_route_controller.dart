import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/utils/material_dialog_service.dart';
import 'package:convenient_way/app/core/utils/motion_toast_service.dart';
import 'package:convenient_way/app/data/models/response_goong_model.dart';
import 'package:convenient_way/app/data/models/route_model.dart';
import 'package:convenient_way/app/data/repository/account_req.dart';
import 'package:convenient_way/app/data/repository/goong_req.dart';
import 'package:convenient_way/app/data/repository/request_model/create_route_model.dart';
import 'package:convenient_way/app/data/repository/response_model/simple_response_model.dart';
import 'package:convenient_way/app/network/exceptions/base_exception.dart';
import 'package:get/get.dart';

class ManageRouteController extends BaseController {
  RxList<RouteAcc> routes = <RouteAcc>[].obs;

  final AccountRep _accountRep = Get.find(tag: (AccountRep).toString());
  late String accountId;
  RouteAcc? newRoute;
  RxInt indexNewRoute = (-1).obs;
  RxBool isLoadingCreateRoute = false.obs;
  RxBool isLoadingFetchRoute = false.obs;

  final GoongReq _goongRepo = Get.find(tag: (GoongReq).toString());

  @override
  void onInit() {
    loadRoutes();
    super.onInit();
  }

  void loadRoutes() {
    accountId = AuthController.instance.account!.id!;
    var future = _accountRep.getRoutes(accountId);
    callDataService<List<RouteAcc>>(
      future,
      onSuccess: (response) {
        routes(response);
      },
      onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError(exception.message);
        }
      },
    );
  }

  void createRouteToList() {
    if (newRoute == null) {
      newRoute = RouteAcc();
      routes.add(newRoute!);
      indexNewRoute.value = routes.length - 1;
    } else {
      MotionToastService.showError(
          'Bạn phải hoàn thành tạo mới lộ trình trước đó');
    }
  }

  void deleteRouteToList() {
    if (newRoute != null) {
      routes.removeLast();
      newRoute = null;
      indexNewRoute.value = -1;
    }
  }

  Future<void> createRouteApi() async {
    if (newRoute != null) {
      CreateRoute model = CreateRoute.fromRoute(newRoute!, accountId);
      var future = _accountRep.createRoute(model);
      callDataService<RouteAcc?>(
        future,
        onSuccess: (response) {
          routes[indexNewRoute.value] = response!;
          newRoute = null;
          indexNewRoute.value = -1;
          MotionToastService.showSuccess('Tạo mới lộ trình thành công');
        },
        onError: (exception) {
          if (exception is BaseException) {
            MotionToastService.showError(exception.message);
          }
        },
        onStart: () => isLoadingCreateRoute.value = true,
        onComplete: () => isLoadingCreateRoute.value = false,
      );
    }
  }

  Future<void> setActiveRouteApi(String routeId) async {
    var future = _accountRep.setActiveRoute(routeId);
    callDataService<SimpleResponseModel>(future, onSuccess: (response) {
      // remove previous active route
      var previousActiveIndex =
          routes.indexWhere((element) => element.isActive == true);
      if (previousActiveIndex != -1) {
        routes[previousActiveIndex].isActive = false;
      }
      // set new active route
      int activeIndex = routes.indexWhere((element) => element.id == routeId);
      routes[activeIndex].isActive = true;
      MotionToastService.showSuccess(
          response.message ?? 'Thay đổi lộ trình thành công');
    }, onError: (exception) {
      if (exception is BaseException) {
        MotionToastService.showError(exception.message);
      }
    });
  }

  Future<void> deleteRouteApi(String routeId) async {
    MaterialDialogService.showConfirmDialog(onConfirmTap: (() {
      var future = _accountRep.deleteRoute(routeId);
      callDataService<SimpleResponseModel>(
        future,
        onSuccess: (response) {
          Get.back(); // close dialog
          MotionToastService.showSuccess(
              response.message ?? 'Xóa lộ trình thành công');
          routes.removeWhere((element) => element.id == routeId);
        },
        onError: (exception) {
          if (exception is BaseException) {
            MotionToastService.showError(exception.message);
          }
        },
      );
    }));
  }

  Future<List<ResponseGoong>> queryLocation(String query) async {
    return _goongRepo.getList(query);
  }

  void updateFromLocation(ResponseGoong response) {
    newRoute!.fromName = response.name;
    newRoute!.fromLongitude = response.longitude;
    newRoute!.fromLatitude = response.latitude;
  }

  void updateToLocation(ResponseGoong response) {
    newRoute!.toName = response.name;
    newRoute!.toLongitude = response.longitude;
    newRoute!.toLatitude = response.latitude;
  }

  bool isEditField(int index) {
    return indexNewRoute.value == index;
  }
}
