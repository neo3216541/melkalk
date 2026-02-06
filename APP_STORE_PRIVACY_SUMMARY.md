# App Store Privacy Summary

This document provides the information needed to fill out the App Privacy section in App Store Connect.

## Data Collection Summary

### Data Types Collected: MINIMAL

#### Identifiers (for Advertising Only)
- **Device ID**: Used by Yandex Mobile Ads for ad serving
- **Advertising ID**: Used for personalized advertising
- **Purpose**: Third-party advertising only
- **Linked to User**: No
- **Used for Tracking**: Yes (by advertising partner)

#### Usage Data
- **Product Interaction**: Ad impressions and clicks
- **Purpose**: Third-party advertising only
- **Linked to User**: No
- **Used for Tracking**: Yes (by advertising partner)

## App Store Connect Privacy Questionnaire Answers

### Does your app collect data?
**Answer**: Yes (only through third-party advertising SDK)

### Data Types Collected

#### Contact Info
- [ ] Name
- [ ] Email Address
- [ ] Phone Number
- [ ] Physical Address
- [ ] Other Contact Info

**Answer**: NONE

#### Health & Fitness
- [ ] Health
- [ ] Fitness

**Answer**: NONE

#### Financial Info
- [ ] Payment Info
- [ ] Credit Info
- [ ] Other Financial Info

**Answer**: NONE

#### Location
- [ ] Precise Location
- [ ] Coarse Location

**Answer**: NONE

#### Sensitive Info
- [ ] Sensitive Info

**Answer**: NONE

#### Contacts
- [ ] Contacts

**Answer**: NONE

#### User Content
- [ ] Emails or Text Messages
- [ ] Photos or Videos
- [ ] Audio Data
- [ ] Gameplay Content
- [ ] Customer Support
- [ ] Other User Content

**Answer**: NONE

#### Browsing History
- [ ] Browsing History

**Answer**: NONE

#### Search History
- [ ] Search History

**Answer**: NONE

#### Identifiers
- [x] User ID (Device ID for ads)
- [x] Device ID (for ad serving)

**Purpose**: Third-Party Advertising
**Linked to User**: No
**Used for Tracking**: Yes

#### Purchases
- [ ] Purchase History

**Answer**: NONE

#### Usage Data
- [x] Product Interaction (ad interactions)

**Purpose**: Third-Party Advertising
**Linked to User**: No
**Used for Tracking**: Yes

#### Diagnostics
- [ ] Crash Data
- [ ] Performance Data
- [ ] Other Diagnostic Data

**Answer**: NONE

#### Other Data
- [ ] Other Data Types

**Answer**: NONE

## Privacy Practices

### Data Linked to User
**Answer**: No data is linked to the user's identity

### Data Used to Track You
**Answer**: Yes
- Device identifiers and usage data are used by our advertising partner (Yandex Mobile Ads) for advertising purposes

### Data Not Collected
- No personal information
- No location data
- No contact information
- No user content
- No health or fitness data
- No financial information

## Third-Party SDKs

### Yandex Mobile Ads SDK
- **Purpose**: Display advertisements
- **Data Collected**: Device identifiers, ad interaction data
- **Privacy Policy**: https://yandex.com/legal/confidential/

## Privacy Policy URL

**Required**: You must provide a publicly accessible URL to your privacy policy.

Suggested hosting options:
1. Your company website
2. GitHub Pages (free)
3. Privacy policy hosting services

**Example URL format**: 
- `https://yourwebsite.com/privacy-policy`
- `https://yourusername.github.io/melcalculator/privacy-policy`

## Additional Notes for App Store Review

1. **No Account Required**: The app does not require users to create an account
2. **Local Storage Only**: All user preferences are stored locally on the device
3. **No Server Communication**: The app does not communicate with any servers except for ad serving
4. **Ad Personalization Control**: Users can control ad personalization through iOS Settings > Privacy > Advertising
5. **COPPA Compliance**: The app is not directed at children under 13
6. **Data Deletion**: All data is deleted when the app is uninstalled

## App Store Connect Screenshots

When submitting, you may need to provide:
- Screenshot showing where users can access privacy information (Settings menu)
- Screenshot showing the app's main functionality
- Explanation of how advertising is implemented

## Recommended App Store Description Addition

Add this to your App Store description:

```
Privacy & Data:
• No personal information collected
• All settings stored locally on your device
• Contains advertisements (Yandex Mobile Ads)
• No account or registration required
```
