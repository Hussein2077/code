const String defaultApplePay = '''{
  "provider": "apple_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "merchantIdentifier": "example",
    "displayName": "Example Name",
    "merchantCapabilities": ["3DS", "debit", "credit"],
    "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
    "countryCode": "US",
    "currencyCode": "USD",
    "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"]
  }
}''';

/// Sample configuration for Google Pay. Contains the same content as the file
/// under `assets/default_payment_profile_google_pay.json`.
const String defaultGooglePay = '''{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "acceptblue",
            "gatewayMerchantId": "3388000000022300507"
          }
        },
        "parameters": {
          "allowedCardNetworks": ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"],
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "billingAddressRequired": true,
          "billingAddressParameters": {
            "format": "FULL",
            "phoneNumberRequired": true
          }
        }
      }
    ],
    "merchantInfo": {
      "merchantId": "BCR2DN4T3GPIDDAG",
      "merchantName": "software"
    },
    "transactionInfo": {
      "countryCode": "US",
      "currencyCode": "USD"
    }
  }
}''';

const String basicGooglePayIsReadyToPay = '''{
  "apiVersion": 2,
  "apiVersionMinor": 0,
  "allowedPaymentMethods": [
    {
      "type": "CARD",
      "parameters": {
        "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
        "allowedCardNetworks": ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"]
      }
    }
  ]
}''';

const String basicGooglePayLoadPaymentData = '''{
  "apiVersion": 2,
  "apiVersionMinor": 0,
  "merchantInfo": {
    "merchantName": "Example Merchant"
  },
  "allowedPaymentMethods": [
    {
      "type": "CARD",
      "parameters": {
        "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
        "allowedCardNetworks": ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"]
      },
      "tokenizationSpecification": {
        "type": "PAYMENT_GATEWAY",
        "parameters": {
          "gateway": "example",
          "gatewayMerchantId": "exampleGatewayMerchantId"
        }
      }
    }
  ],
  "transactionInfo": {
    "totalPriceStatus": "FINAL",
    "totalPrice": "12.34",
    "currencyCode": "USD"
  }
}''';

const String invalidGooglePayIsReadyToPay = '''{
  "apiVersion": 2,
  "apiVersionMinor": 0,
  "allowedPaymentMethods": [
    {
      "type": "CARD",
      "parameters": {}
    }
  ]
}''';

const String invalidGooglePayLoadPaymentData = '''{
  "apiVersion": 2,
  "apiVersionMinor": 0,
  "merchantInfo": {
    "merchantName": "Example Merchant"
  },
  "allowedPaymentMethods": [
    {
      "type": "CARD",
      "parameters": {
        "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
        "allowedCardNetworks": ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"]
      },
      "tokenizationSpecification": {
        "type": "PAYMENT_GATEWAY",
        "parameters": {
          "gateway": "example",
          "gatewayMerchantId": "exampleGatewayMerchantId"
        }
      }
    }
  ],
  "transactionInfo": {
    "totalPriceStatus": "FINAL",
    "totalPrice": "12.34",
    "currencyCode": "USD"
  }
}''';