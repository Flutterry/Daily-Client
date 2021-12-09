import 'dart:io';

const googleApiKey = '*****************';

const huaweiGalleryLink = '';
const googlePlayLink = '';
const appStoreLink = '';

const baseApi = '*********************';

final versionApi = 'version/${Platform.isAndroid ? 'android' : 'ios'}';
const tokenApi = 'update-notification-token';
const logoutApi = 'logout';
const introductionApi = 'introductions';
const pinApi = 'verification_code';
const loginApi = 'login';
const featureApi = 'features';
const nearMeApi = 'companies/near-me';
const restaurantApi = 'companies';
const searchRestaurantApi = 'companies/search';
const locationApi = 'locations';
String companyProductApi(int id) => 'companies/$id';
const nonContractedCartApi = 'non-contracted-carts';
const faqApi = 'faqs';
const aboutApi = 'about';
String companyCommentsApi(int id) => 'companies/$id/comments';
String productApi(int id) => 'products/$id';

//todo this apis not found
const welcomeMessageApi = '';
const bannersApi = '';
const cartApi = '';
