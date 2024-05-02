class APIURL {
  //static const production = "https://bsoe.meestdrive.in/";
  static const production = "http://sales.meestdrive.in/";
  

  static const imageURL = "https://s3.ap-south-1.amazonaws.com/erpbestone/";
  static const MAIN_URL = production;
  static const API_URL = MAIN_URL + "api";

  static const String LOGIN_API = "$API_URL/user/authIn";
  static const String CHECK_IN_URL = "$API_URL/attendance/punchIN";
  static const String CHECK_Out_URL = "$API_URL/attendance/punchOUT";
  static const String LOCATION_TRACKER = "$API_URL/sales/locationSaver";
  static const String ATTENDANCC_HISTORY = "$API_URL/attendance/list/2024/";
  static const String LOG_OUT = "$API_URL/user/authOut";
  static const String GET_ME = "$API_URL/authorize/check";

  static const String GET_ALL_TASK = "$API_URL/employee/task-list-all";
  static const String UPDATE_TASK = "$API_URL/employee/task-submit";
  static const String UPDATE_PROFILE = "$API_URL/user/profileUpdate";
  static const String TADA_LIST_URL = "$API_URL/employee/tada-lists";
  static const String TADA_STORE_URL = "$API_URL/employee/tada/store";
  static const String PROFILE_URL = "$API_URL/employee/get-profile-details";
  static const String TADA_UPDATE_URL = "$API_URL/employee/tada/update/";
  static const String HOME_PAGE_URL = "$API_URL/dashboard/overall";

  static const String BUUCKET_LEAVE = "$API_URL/leaves/allTakenLeaveTypes";

  static const String HOLIDAYS_API = "$API_URL/employee/holidayList";

  static const String SELECT_LEAVE_API = "$API_URL/leave/leaveTypes";

  static const String LEAVE_REQUEST_API = "$API_URL/leave/applyLeave";
  static const String LEAVE_LIST_DETAILS_API = "$API_URL/leave/list?";
  static const String SHOP_LIST = "$API_URL/employee/shopsList";
  static const String DISTRIBUTOR_LIST = "$API_URL/sales/distributors/list";
  static const String DISTRIBUTOR_STATE_LIST = "$API_URL/sales/states";
  static const String DISTRIBUTOR_DISTRICT_LIST = "$API_URL/sales/districts/";
  static const String CREATE_DISTRIBUTOR = "$API_URL/sales/distributors/save";
  static const String CREATE_RETAILER = "$API_URL/sales/retailers/add";
  static const String GET_RETAILER_LIST = "$API_URL/sales/retailers/list";
  static const String GET_ALL_RETAILER_AND_DISTRI =
      "$API_URL/sales/partners/total";
  static const String RETAILER_UPDATE = "$API_URL/sales/retailers/update/";
  static const String DISTRIBUTORS_UPDATE =
      "$API_URL/sales/distributors/update/";
  static const String PRODUCT_LIST =
      "$API_URL/sales/distributor/fetchDsitributorProducts";
  static const String CREATE_ORDER =
      "$API_URL/sales/distributor/generateAdvanceOrder";
  static const String ORDER_LIST = "$API_URL/sales/retailer/advanceOrders/";
  static const String UPDATE_ORDER =
      "$API_URL/sales/retailer/advanceOrdersUpdate";
  static const String ORDER_DELETE =
      "$API_URL/sales/retailer/advanceOrderDelete/";
  static const String WHATSAPP_API =
      "https://graph.facebook.com/v18.0/249858914881854/messages";
  static const String WHATSAPP_BEARER =
      "Bearer EAAGESnPemBYBO1Sozg1i9bTZBx1s6vftHuSNw41wAAQ5ZB7WxXvrxLi24GQISTR7fqg0TlFv5R9MO7BIYqrjbpdT5M1ixPYs21ulI4sq0yO3KCyyGxfoZBb5VhXGet7O87Amk1OKI0DND3LyWFnehYbCjr9pYdP8risOtZCxMgrQAi7U2ggslT0JBPEvqZC77gromRO81lKWVZBP9YzESoeBKJ4LEZD";
  static const String ADVANCE_ORDER =
      "$API_URL/sales/advanceOrderProcessingList";
  static const String CREATE_INVENTORY = "$API_URL/sales/salesInventory/create";
  static const String GET_INVENTORY_LIST =
      "$API_URL/sales/getInventoryDataSales";

  static final String forceFully = "forceFully";
  static final String Version = "Version";
  static final String appUpdate = "appUpdate";
  static final String updateUrl = "updateUrl";
  static final String updateMessage = "updateMessage";

  static const String UPLOAD_OFFINTERNET_LOCATION =
      "$API_URL/sales/locationSaverOffData";

  static const String DAILY_TASK = "$API_URL/task/taskList";
  static const String DAILY_TASK_DETAILS = "$API_URL/task/taskDetails";
}
