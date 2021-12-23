import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

final getIt = GetIt.instance;
const initializerName = 'initGetIt';

@InjectableInit(
  initializerName: initializerName,
  preferRelativeImports: true,
  asExtension: false,
)
configureDependencies() => initGetIt(getIt);
