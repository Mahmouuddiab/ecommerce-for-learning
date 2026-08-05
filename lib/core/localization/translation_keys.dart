class TranslationKeys {
  TranslationKeys._();
  static const SignUp signUp = SignUp();
  static const Login login = Login();
  static const ForgotPassword forgotPassword = ForgotPassword();
  static const ResetPassword resetPassword = ResetPassword();
  static const VerifyCode verifyCode = VerifyCode();
  static const Settings settings = Settings();
  static const Address address = Address();
  static const Cart cart = Cart();
  static const Home home = Home();
  static const Navigation navigation = Navigation();
  static const Profile profile = Profile();
  static const PrivacyPolicy privacyPolicy = PrivacyPolicy();
  static const Wishlist wishlist = Wishlist();
  static const Checkout checkout = Checkout();
  static const Category category = Category();
  static const ProductDetails productDetails = ProductDetails();
  static const SubCategoryProducts subCategoryProducts = SubCategoryProducts();
}

class SignUp {
  const SignUp();
  final String fullName = "sign_up.full_name";
  final String mobileNumber = "sign_up.mobile_number";
  final String emailAddress = "sign_up.email_address";
  final String password = "sign_up.password";
  final String confirmPassword = "sign_up.confirm_password";
  final String fullNameHint = "sign_up.full_name_hint";
  final String mobileNumberHint = "sign_up.mobile_number_hint";
  final String emailHint = "sign_up.email_hint";
  final String passwordHint = "sign_up.password_hint";
  final String confirmPasswordHint = "sign_up.confirm_password_hint";
  final String signUpButton = "sign_up.sign_up_button";
  final String alreadyHaveAccount = "sign_up.already_have_account";
  final String login = "sign_up.login";
}

class Login {
  const Login();
  final String welcomeBack = "login.welcome_back";
  final String pleaseSignIn = "login.please_sign_in";
  final String email = "login.email";
  final String password = "login.password";
  final String emailHint = "login.email_hint";
  final String passwordHint = "login.password_hint";
  final String forgotPassword = "login.forgot_password";
  final String loginButton = "login.login_button";
  final String dontHaveAccount = "login.dont_have_account";
  final String createAccount = "login.create_account";
}

class ForgotPassword {
  const ForgotPassword();
  final String title = "forgot_password.title";
  final String subtitle = "forgot_password.subtitle";
  final String email = "forgot_password.email";
  final String emailHint = "forgot_password.email_hint";
  final String sendResetCode = "forgot_password.send_reset_code";
}

class ResetPassword {
  const ResetPassword();
  final String resetPasswordLabel = "reset_password.reset_password_label";
  final String subtitlePrefix = "reset_password.subtitle_prefix";
  final String newPasswordHint = "reset_password.new_password_hint";
  final String passwordEmptyValidation = "reset_password.password_empty_validation";
  final String passwordLengthValidation = "reset_password.password_length_validation";
  final String resetButton = "reset_password.reset_button";
  final String resetSuccessMessage = "reset_password.reset_success_message";
}

class VerifyCode {
  const VerifyCode();
  final String title = "verify_code.title";
  final String subtitlePrefix = "verify_code.subtitle_prefix";
  final String incompleteCodeValidation = "verify_code.incomplete_code_validation";
  final String codeVerifiedSuccess = "verify_code.code_verified_success";
  final String resendCode = "verify_code.resend_code";
  final String verifyButton = "verify_code.verify_button";
}

class Settings {
  const Settings();
  final String title = "settings.title";
  final String myProfile = "settings.my_profile";
  final String language = "settings.language";
  final String english = "settings.english";
  final String arabic = "settings.arabic";
  final String notifications = "settings.notifications";
}

class Address {
  const Address();
  final String addNewAddress = "address.add_new_address";
  final String addressDetails = "address.address_details";
  final String fillInformationSubtitle = "address.fill_information_subtitle";
  final String savedAddresses = "address.saved_addresses";
  final String addressLabel = "address.address_label";
  final String city = "address.city";
  final String phoneNumber = "address.phone_number";
  final String detailedAddress = "address.detailed_address";
  final String labelHint = "address.label_hint";
  final String cityHint = "address.city_hint";
  final String phoneHint = "address.phone_hint";
  final String detailsHint = "address.details_hint";
  final String labelValidation = "address.label_validation";
  final String cityValidation = "address.city_validation";
  final String phoneValidation = "address.phone_validation";
  final String detailsValidation = "address.details_validation";
  final String saveAddress = "address.save_address";
  final String addressAddedSuccess = "address.address_added_success";
  final String deleteAddress = "address.delete_address";
  final String deleteConfirmMessage = "address.delete_confirm_message";
  final String cancel = "address.cancel";
  final String delete = "address.delete";
  final String failedToDelete = "address.failed_to_delete";
  final String addressDeletedSuccess = "address.address_deleted_success";
  final String noAddressesFound = "address.no_addresses_found";
  final String tryAgain = "address.try_again";
}

class Cart {
  const Cart();
  final String deleteItem = "cart.delete_item";
  final String deleteConfirmMessage = "cart.delete_confirm_message";
  final String cancel = "cart.cancel";
  final String delete = "cart.delete";
  final String productRemovedSuccess = "cart.product_removed_success";
  final String title = "cart.title";
  final String failedToLoad = "cart.failed_to_load";
  final String tryAgain = "cart.try_again";
  final String emptyCartTitle = "cart.empty_cart_title";
  final String emptyCartSubtitle = "cart.empty_cart_subtitle";
  final String totalPrice = "cart.total_price";
  final String currencyEgp = "cart.currency_egp";
  final String checkOut = "cart.check_out";
}

class Home {
  const Home();
  final String popularCategories = "home.popular_categories";
  final String noCategoriesFound = "home.no_categories_found";
  final String popularBrands = "home.popular_brands";
  final String noBrandsFound = "home.no_brands_found";
}

class Navigation {
  const Navigation();
  final String home = "navigation.home";
  final String categories = "navigation.categories";
  final String wishlist = "navigation.wishlist";
  final String profile = "navigation.profile";
}

class Profile {
  const Profile();
  final String logoutTitle = "profile.logout_title";
  final String logoutConfirmMessage = "profile.logout_confirm_message";
  final String cancel = "profile.cancel";
  final String logout = "profile.logout";
  final String defaultAvatarLetter = "profile.default_avatar_letter";
  final String phone = "profile.phone";
  final String role = "profile.role";
  final String wishlist = "profile.wishlist";
  final String savedItemsSuffix = "profile.saved_items_suffix";
  final String savedAddresses = "profile.saved_addresses";
  final String addressesSuffix = "profile.addresses_suffix";
  final String privacyPolicy = "profile.privacy_policy";
  final String contactUs = "profile.contact_us";
  final String termsOfService = "profile.terms_of_service";
  final String inviteFriends = "profile.invite_friends";
  final String signOut = "profile.sign_out";
  final String failedToLoadProfile = "profile.failed_to_load_profile";
  final String tryAgain = "profile.try_again";
}

class PrivacyPolicy {
  const PrivacyPolicy();
  final String title = "privacy_policy.title";
  final String headerTitle = "privacy_policy.header_title";
  final String lastUpdated = "privacy_policy.last_updated";
  final String headerSubtitle = "privacy_policy.header_subtitle";
  final String section1Title = "privacy_policy.section_1_title";
  final String section1Content = "privacy_policy.section_1_content";
  final String section2Title = "privacy_policy.section_2_title";
  final String section2Content = "privacy_policy.section_2_content";
  final String section3Title = "privacy_policy.section_3_title";
  final String section3Content = "privacy_policy.section_3_content";
  final String section4Title = "privacy_policy.section_4_title";
  final String section4Content = "privacy_policy.section_4_content";
  final String section5Title = "privacy_policy.section_5_title";
  final String section5Content = "privacy_policy.section_5_content";
  final String haveQuestions = "privacy_policy.have_questions";
  final String contactSupportSubtitle = "privacy_policy.contact_support_subtitle";
  final String contactButton = "privacy_policy.contact_button";
}

class Wishlist {
  const Wishlist();
  final String title = "wishlist.title";
  final String defaultSuccessMessage = "wishlist.default_success_message";
  final String failedToLoad = "wishlist.failed_to_load";
  final String tryAgain = "wishlist.try_again";
  final String emptyWishlistTitle = "wishlist.empty_wishlist_title";
  final String emptyWishlistSubtitle = "wishlist.empty_wishlist_subtitle";
}

class Checkout {
  const Checkout();
  final String title = "checkout.title";
  final String orderCreatedSuccess = "checkout.order_created_success";
  final String noAddressesTitle = "checkout.no_addresses_title";
  final String addNewAddress = "checkout.add_new_address";
  final String placeCashOrder = "checkout.place_cash_order";
  final String errorLoadingAddresses = "checkout.error_loading_addresses";
  final String tryAgain = "checkout.try_again";
  final String reviewDialogTitle = "checkout.review_dialog_title";
  final String reviewDialogSubtitle = "checkout.review_dialog_subtitle";
  final String ratingTerrible = "checkout.rating_terrible";
  final String ratingBad = "checkout.rating_bad";
  final String ratingOkay = "checkout.rating_okay";
  final String ratingGood = "checkout.rating_good";
  final String ratingExcellent = "checkout.rating_excellent";
  final String reviewHint = "checkout.review_hint";
  final String skip = "checkout.skip";
  final String submit = "checkout.submit";
  final String reviewAddedSuccess = "checkout.review_added_success";
}

class Category {
  const Category();
  final String noCategoriesFound = "category.no_categories_found";
  final String upToFiftyPercentOff = "category.up_to_fifty_percent_off";
  final String shopNow = "category.shop_now";
  final String noSubCategoriesAvailable = "category.no_sub_categories_available";
  final String retry = "category.retry";
}

class ProductDetails {
  const ProductDetails();
  final String title = "product_details.title";
  final String addedToCartSuccess = "product_details.added_to_cart_success";
  final String sold = "product_details.sold";
  final String description = "product_details.description";
  final String readLess = "product_details.read_less";
  final String readMore = "product_details.read_more";
  final String size = "product_details.size";
  final String color = "product_details.color";
  final String totalPrice = "product_details.total_price";
  final String currencyEgp = "product_details.currency_egp";
  final String addToCart = "product_details.add_to_cart";
  final String reviews = "product_details.reviews";
  final String failedToLoadReviews = "product_details.failed_to_load_reviews";
  final String noReviewsYet = "product_details.no_reviews_yet";
}

class SubCategoryProducts {
  const SubCategoryProducts();
  final String addedToCartSuccess = "subcategory_products.added_to_cart_success";
  final String wishlistUpdatedSuccess = "subcategory_products.wishlist_updated_success";
  final String failedToLoad = "subcategory_products.failed_to_load";
  final String retry = "subcategory_products.retry";
  final String noProductsAvailable = "subcategory_products.no_products_available";
}