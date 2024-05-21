import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/network/connection_checker.dart';

abstract class InternetExceptionThrower {
  Future throwInternetException();
}

class InternetExceptionThrowerImpl implements InternetExceptionThrower {
  final ConnectionChecker _connectionChecker;

  InternetExceptionThrowerImpl(this._connectionChecker);

  @override
  Future throwInternetException() async {
    if (await _connectionChecker.isConnected()) return true;
    throw NoInternetException();
  }
}
