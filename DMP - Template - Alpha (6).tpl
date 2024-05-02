___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "DMP - Template - Alpha",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "event_type",
    "displayName": "DMP Event Type",
    "macrosInSelect": true,
    "selectItems": [
      {
        "value": "global_tag",
        "displayValue": "DMP Global Site Tag"
      },
      {
        "value": "conversion_tag",
        "displayValue": "DMP Conversion Tag"
      }
    ],
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "wihpid",
    "displayName": "WIHPID",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "NON_EMPTY"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "event_type",
        "paramValue": "conversion_tag",
        "type": "EQUALS"
      },
      {
        "paramName": "event_type",
        "paramValue": "global_tag",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "reference_id",
    "displayName": "Booking reference ID",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "event_type",
        "paramValue": "conversion_tag",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "currency",
    "displayName": "Currency",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "event_type",
        "paramValue": "conversion_tag",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "amount_with_tax",
    "displayName": "Total amount With Tax",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "event_type",
        "paramValue": "conversion_tag",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "checkin",
    "displayName": "Checkin",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Date format : YYYY-MM-DD",
    "enablingConditions": [
      {
        "paramName": "event_type",
        "paramValue": "conversion_tag",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "checkout",
    "displayName": "Checkout",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Date format : YYYY-MM-DD",
    "enablingConditions": [
      {
        "paramName": "event_type",
        "paramValue": "conversion_tag",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "dmpclid",
    "displayName": "DMP Click ID",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "event_type",
        "paramValue": "conversion_tag",
        "type": "EQUALS"
      },
      {
        "paramName": "event_type",
        "paramValue": "global_tag",
        "type": "EQUALS"
      }
    ],
    "help": "Need to be set only if the wh_token can be caught through the data_layer and not through the URL"
  },
  {
    "type": "TEXT",
    "name": "custom1",
    "displayName": "Page URL",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "custom2",
    "displayName": "Referrer",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "custom3",
    "displayName": "Environment Name",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "custom4",
    "displayName": "Container ID",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "custom5",
    "displayName": "Event",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
const log = require('logToConsole');
const encodeUriComponent = require('encodeUriComponent');
const makeString = require('makeString');
const sendPixel = require('sendPixel');
const queryPermission = require('queryPermission');
const getQueryParameters = require('getQueryParameters');
const getUrl = require('getUrl');
const setCookie = require('setCookie');
const parseUrl = require('parseUrl');
const getCookieValues = require('getCookieValues');
const getReferrerUrl = require('getReferrerUrl');
const getTimestampMillis = require('getTimestampMillis');




log('data =', data);

const sendConfirmationTag = (data) => {
    const wihpid = data.wihpid;
    const reference_id = data.reference_id;
    const currency = data.currency;
    const amount_with_tax = data.amount_with_tax;
    const checkin = data.checkin;
    const checkout = data.checkout;
    const dmpclid = data.dmpclid;
    const event_type = data.event_type;
    const cookieName = 'wh_dmp_' + wihpid;
    const custom1 = data.custom1;
    const custom2 = data.custom2;
    const custom3 = data.custom3;
    const custom4 = data.custom4;
    const custom5 = data.custom5;

  

    var pixelUrl = 'https://secure-hotel-tracker.com/wh/conv_gt/?';

    if (wihpid) {

        log('wihpid =', wihpid);
        pixelUrl += 'wihpid=' + encodeUriComponent(makeString(wihpid));
    } else {
        log('wihpid = undefined');
    }

    if (reference_id) {
        log('reference_id =', reference_id);
        pixelUrl += '&reference_id=' + encodeUriComponent(makeString(reference_id));

    } else {
        log('reference_id = undefined');
    }

    if (currency) {
        log('currency =', currency);
        pixelUrl += '&currency=' + encodeUriComponent(makeString(currency));

    } else {
        log('currency = undefined');
    }

    if (amount_with_tax) {
        log('amount_with_tax =', amount_with_tax);
        pixelUrl += '&amount_with_tax=' + encodeUriComponent(makeString(amount_with_tax));

    } else {
        log('amount_with_tax = undefined');
    }

    if (checkin) {
        log('checkin =', checkin);
        pixelUrl += '&checkin=' + encodeUriComponent(makeString(checkin));

    } else {
        log('checkin = undefined');
    }

    if (checkout) {
        log('checkout =', checkout);
        pixelUrl += '&checkout=' + encodeUriComponent(makeString(checkout));

    } else {
        log('checkout = undefined');
    }

    pixelUrl += '&idbe=3&date_format=YYYY-MM-DD';


    if (queryPermission('get_cookies', cookieName)) {
        const cookie_values = getCookieValues(cookieName);
        log('cookie_values =', cookie_values);
        pixelUrl += '&whtoken_c=' + cookie_values;
    } else {
        log('cookies_values = undefined', cookieName);

    }

    if (queryPermission('get_url')) {
        const current_url = getUrl('all');
        log('current_url =', current_url);
        pixelUrl += '&current_url=' + encodeUriComponent(makeString(current_url));
    } else {
        log('current_url = not readable');
    }




    if (queryPermission('get_referrer', 'host') && (queryPermission('get_referrer', 'path')) && (queryPermission('get_referrer', 'query'))) {
        const referrer_all = getReferrerUrl('host') + getReferrerUrl('path') + "?" + getReferrerUrl('query');

        log('referrer_all =', referrer_all);
        pixelUrl += '&referrer_all=' + encodeUriComponent(makeString(referrer_all));
    } else {
        log('referrer_all = not readable');
        if (queryPermission('get_referrer', 'query')) {
            const referrer_query = getReferrerUrl('query');
            log('referrer_query =', referrer_query);
            pixelUrl += '&referrer_query=' + encodeUriComponent(makeString(referrer_query));

        } else {
            log('referrer_params = not readable');
        }


        if (queryPermission('get_referrer', 'path')) {
            const referrer_path = getReferrerUrl('path');
            log('referrer_path =', referrer_path);
            pixelUrl += '&referrer_path=' + encodeUriComponent(makeString(referrer_path));

        } else {
            log('referrer_path = not readable');
        }

        if (queryPermission('get_referrer', 'host')) {
            const referrer_host = getReferrerUrl('host');
            log('referrer_host =', referrer_host);
            pixelUrl += '&referrer_host=' + encodeUriComponent(makeString(referrer_host));

        } else {
            log('referrer_host = not readable');
        }

    }

    if (dmpclid) {
        log('dmpclid =', dmpclid);
        pixelUrl += '&dmpclid=' + encodeUriComponent(makeString(dmpclid));
    } else {
        log('dmpclid = not readable');
    }

    if (custom1) {
        log('custom1 =', custom1);
        pixelUrl += '&custom1=' + encodeUriComponent(makeString(custom1));
    } else {
        log('custom1 = not readable');
    }

    if (custom2) {
        log('custom2 =', custom2);
        pixelUrl += '&custom2=' + encodeUriComponent(makeString(custom2));
    } else {
        log('custom2 = not readable');
    }

    if (custom3) {
        log('custom3 =', custom3);
        pixelUrl += '&custom3=' + encodeUriComponent(makeString(custom3));
    } else {
        log('custom3 = not readable');
    }

    if (custom4) {
        log('custom4 =', custom4);
        pixelUrl += '&custom4=' + encodeUriComponent(makeString(custom4));
    } else {
        log('custom4 = not readable');
    }

    if (custom5) {
        log('custom5 =', custom5);
        pixelUrl += '&custom5=' + encodeUriComponent(makeString(custom5));
    } else {
        log('custom5 = not readable');
    }
    // Call data.gtmOnSuccess when the tag is finished.



    if (queryPermission('send_pixel', pixelUrl)) {
        sendPixel(pixelUrl, data.gtmOnSuccess, data.gtmOnFailure);
        log('send_pixel=', pixelUrl);

    } else {
        log('send_pixel = not readable', pixelUrl);

    }

};

const sendTagCatcher = (data) => {
    const wihpid_TagCatcher = data.wihpid;
    const cookieName_TagCatcher = 'wh_dmp_' + wihpid_TagCatcher;
    let wh_token = '';
    if (queryPermission('get_url', 'query', 'wh_token')) {
        wh_token = getQueryParameters('wh_token');
    }
    if (wh_token != undefined && wh_token != '') {
        const options = {
            'domain': getUrl('host'),
            'path': '/',
            'max-age': 30 * 24 * 60 * 60
        };
        log('set cookie permission = ' + queryPermission('set_cookies', cookieName_TagCatcher, options));
        if (queryPermission('set_cookies', cookieName_TagCatcher, options)) {
            setCookie(cookieName_TagCatcher, wh_token, options);
            log('set cookie successfully.', wh_token);
        }
    }

};
const sendHeartbeat = (data) => {
    const wihp_debug = data.wihpid;
    const reference_id_debug = data.reference_id;
    const currency_debug = data.currency;
    const amount_with_tax_debug = data.amount_with_tax;
    const checkin_debug = data.checkin;
    const checkout_debug = data.checkout;
    const dmpclid_debug = data.dmpclid;
    const event_type_debug = data.event_type;
    const cookieName_debug = 'wh_dmp_' + wihp_debug;
    const custom1_debug = data.custom1;
    const custom2_debug = data.custom2;
    const custom3_debug = data.custom3;
    const custom4_debug = data.custom4;
    const custom5_debug = data.custom5;

  
    var pixelUrl_debug = 'https://p.relay-t.io/beat.gif?';

    if (wihp_debug) {

        log('wihp_debug =', wihp_debug);
        pixelUrl_debug += 'wihp_debug=' + encodeUriComponent(makeString(wihp_debug));
    } else {
        log('wihp_debug = undefined');
    }

    if (reference_id_debug) {
        log('reference_id_debug =', reference_id_debug);
        pixelUrl_debug += '&reference_id_debug=' + encodeUriComponent(makeString(reference_id_debug));

    } else {
        log('reference_id_debug = undefined');
    }

    if (currency_debug) {
        log('currency_debug =', currency_debug);
        pixelUrl_debug += '&currency_debug=' + encodeUriComponent(makeString(currency_debug));

    } else {
        log('currency_debug = undefined');
    }

    if (amount_with_tax_debug) {
        log('amount_with_tax_debug =', amount_with_tax_debug);
        pixelUrl_debug += '&amount_with_tax_debug=' + encodeUriComponent(makeString(amount_with_tax_debug));

    } else {
        log('amount_with_tax_debug = undefined');
    }

    if (checkin_debug) {
        log('checkin_debug =', checkin_debug);
        pixelUrl_debug += '&checkin_debug=' + encodeUriComponent(makeString(checkin_debug));

    } else {
        log('checkin_debug = undefined');
    }

    if (checkout_debug) {
        log('checkout_debug =', checkout_debug);
        pixelUrl_debug += '&checkout_debug=' + encodeUriComponent(makeString(checkout_debug));

    } else {
        log('checkout_debug = undefined');
    }

    pixelUrl_debug += '&idbe=3&date_format=YYYY-MM-DD';


    if (queryPermission('get_cookies', cookieName_debug)) {
        const cookie_values_debug = getCookieValues(cookieName_debug);
        log('cookie_values_debug =', cookie_values_debug);
        pixelUrl_debug += '&whtoken_c_debug=' + cookie_values_debug;
    } else {
        log('cookie_values_debug = undefined', cookieName_debug);

    }

    if (queryPermission('get_url')) {
        const current_url_debug = getUrl('all');
        log('current_url_debug =', current_url_debug);
        pixelUrl_debug += '&current_url_debug=' + encodeUriComponent(makeString(current_url_debug));
    } else {
        log('current_url_debug = not readable');
    }




    if (queryPermission('get_referrer', 'host') && (queryPermission('get_referrer', 'path')) && (queryPermission('get_referrer', 'query'))) {
        const referrer_all_debug = getReferrerUrl('host') + getReferrerUrl('path') + "?" + getReferrerUrl('query');

        log('referrer_all_debug =', referrer_all_debug);
        pixelUrl_debug += '&referrer_all_debug=' + encodeUriComponent(makeString(referrer_all_debug));
    } else {
        log('referrer_all_debug = not readable');
        if (queryPermission('get_referrer', 'query')) {
            const referrer_query_debug = getReferrerUrl('query');
            log('referrer_query_debug =', referrer_query_debug);
            pixelUrl_debug += '&referrer_query_debug=' + encodeUriComponent(makeString(referrer_query_debug));

        } else {
            log('referrer_params_debug = not readable');
        }


        if (queryPermission('get_referrer', 'path')) {
            const referrer_path_debug = getReferrerUrl('path');
            log('referrer_path_debug =', referrer_path_debug);
            pixelUrl_debug += '&referrer_path_debug=' + encodeUriComponent(makeString(referrer_path_debug));

        } else {
            log('referrer_path_debug = not readable');
        }

        if (queryPermission('get_referrer', 'host')) {
            const referrer_host_debug = getReferrerUrl('host');
            log('referrer_host_debug =', referrer_host_debug);
            pixelUrl_debug += '&referrer_host_debug=' + encodeUriComponent(makeString(referrer_host_debug));

        } else {
            log('referrer_host_debug = not readable');
        }

    }

    if (dmpclid_debug) {
        log('dmpclid_debug =', dmpclid_debug);
        pixelUrl_debug += '&dmpclid_debug=' + encodeUriComponent(makeString(dmpclid_debug));
    } else {
        log('dmpclid_debug = not readable');
    }

    if (event_type_debug) {
        log('event_type_debug =', event_type_debug);
        pixelUrl_debug += '&event_type_debug=' + encodeUriComponent(makeString(event_type_debug));
    } else {
        log('event_type_debug = not readable');
    }

    if (custom1_debug) {
        log('custom1_debug =', custom1_debug);
        pixelUrl_debug += '&custom1_debug=' + encodeUriComponent(makeString(custom1_debug));
    } else {
        log('custom1_debug = not readable');
    }

    if (custom2_debug) {
        log('custom2_debug =', custom2_debug);
        pixelUrl_debug += '&custom2_debug=' + encodeUriComponent(makeString(custom2_debug));
    } else {
        log('custom2_debug = not readable');
    }

    if (custom3_debug) {
        log('custom3_debug =', custom3_debug);
        pixelUrl_debug += '&custom3_debug=' + encodeUriComponent(makeString(custom3_debug));
    } else {
        log('custom3_debug = not readable');
    }
  
    if (custom4_debug) {
        log('custom4_debug =', custom4_debug);
        pixelUrl_debug += '&custom4_debug=' + encodeUriComponent(makeString(custom4_debug));
    } else {
        log('custom4_debug = not readable');
    }
  
    if (custom5_debug) {
        log('custom5_debug =', custom5_debug);
        pixelUrl_debug += '&custom5_debug=' + encodeUriComponent(makeString(custom5_debug));
    } else {
        log('custom5_debug = not readable');
    }
    // Call data.gtmOnSuccess when the tag is finished.

    pixelUrl_debug += '&dmp_date_debug=' + encodeUriComponent(makeString(getTimestampMillis()));


    if (queryPermission('send_pixel', pixelUrl_debug)) {
        sendPixel(pixelUrl_debug, data.gtmOnSuccess, data.gtmOnFailure);
        log('send_pixel_debug=', pixelUrl_debug);

    } else {
        log('send_pixel_debug = not readable', pixelUrl_debug);

    }

};

const page_type = data.event_type;

sendTagCatcher(data);

if (page_type.toLowerCase() == 'conversion_tag') {

    sendConfirmationTag(data);

}
sendHeartbeat(data);

data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_referrer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "path",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "extension",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "query",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "host",
          "value": {
            "type": 8,
            "boolean": true
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_pixel",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 25/04/2024 15:04:36


