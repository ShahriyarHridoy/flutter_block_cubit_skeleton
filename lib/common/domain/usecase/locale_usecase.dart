import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/common/domain/repository/locale_repository.dart';

class ReadLocaleUsecase {
  final LocaleRepository _localeRepository;

  ReadLocaleUsecase(this._localeRepository);

  Locale call() {
    return _localeRepository.readLocale();
  }
}

class SaveLocaleUsecase {
  final LocaleRepository _localeRepository;

  SaveLocaleUsecase(this._localeRepository);

  Future<bool> call(Locale locale) async {
    return await _localeRepository.saveLocale(locale);
  }
}
