import 'package:get/get.dart';

mixin LoadingMixin {
  final loading = false.obs;

  set isLoading(bool value) => loading.value = value;

  bool get isLoading => loading.value;
}
