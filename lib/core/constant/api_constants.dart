class ApiConstants {
  ApiConstants._();

// Live Base API Url
  static const baseCommonApiUrl = 'http://18.181.146.228:8080';

// Tanvir Local
  // static const baseCommonApiUrl = 'http://192.168.0.116:3000/common/api/v1';
  // static const baseIndividualApiUrl = 'http://192.168.0.116:3001/individual/api/v1';

  static const imageUrl = '';
  static const signInUrl = "/auth/login";
  static const signUpUrl = "/auth/register";
  static const signOutUrl = "/user/signout";
  static const profile = "/auth/profile";
  static const updateProfileUrl = "/auth/update-profile";
  static const addCategoriesUrl = "/category/add-category";

  static const incomeCategoriesUrl = "/category/income-categories";
  static const expenseCategoriesUrl = "/category/expense-categories";
  static const editCategoriesUrl = "/category/edit-category";
  static const refreshTokenUrl = "/auth/refresh-token";
  static const allAccountUrl = "/account/all-accounts";
  static const addAccountUrl = "/account/add-account-type";
  static const editAccountUrl = "/account/edit-account-type";
  static const deleteAccountUrl = "/account/delete-account-type?accountId=";
  static const deleteCategoriesUrl = "/category/delete-category?categoryId=";
  static const transactionListUrl = "/transaction/transaction-list";
  static const addTransactionUrl = "/transaction/add-transaction";
  static const sumOfTransactionUrl = "/transaction/sum-of-transaction";
  static const deleteTransactionUrl =
      "/transaction/delete-transaction?transactionId=";
  static const sendOtpUrl = "/auth/forgot-password";
  static const checkOtpUrl = "/auth/validate-otp";
  static const resetPasswordUrl = "/auth/reset-password";
  static const editTransactionUrl = "/transaction/edit-transaction";
  static const changePasswordUrl = "/auth/change-password";
  static const setBudgetUrl = "/budget/add-budget";
  static const budgetListUrl = "/budget/budget-list";
  static const deleteBudgetUrl = "/budget/delete-budget?budgetId=";
  static const editBudgetUrl = "/budget/edit-budget";
  static const analysisListUrl = "/transaction/transaction-list-graph";
  static const checkSavingsUrl = "/savings/check-savings";
  static const savingsListUrl = "/savings/monthly-savings";
}
