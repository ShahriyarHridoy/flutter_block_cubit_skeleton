// import 'package:flutter_block_cubit_skeleton/common/data/data_source/local/token_source.dart';

// abstract class HeaderProviderAuth {
//   Map<String, String> call();
// }

// class HeaderProviderImplAuth implements HeaderProviderAuth {
//   @override
//   Map<String, String> call() {
//     return {
//       // "Accept": "application/json",
//       // "Content-Type": "application/json",
//     };
//   }
// }

// class AuthHeaderProviderToken extends HeaderProviderImplAuth {
//   final TokenSource _tokenSource;

//   AuthHeaderProviderToken(this._tokenSource);
//   @override
//   Map<String, String> call() {
//     return Map.from(super.call())
//       ..putIfAbsent(
//           "Authorization", () => "Bearer" + " " + _tokenSource.getToken());
//   }
// }
