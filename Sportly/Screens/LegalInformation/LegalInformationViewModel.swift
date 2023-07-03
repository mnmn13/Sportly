//
//  LegalInformationViewModel.swift
//  Sportly
//
//  Created by MN on 30.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

protocol LegalInformationViewModelType {
    func getText() -> String
}

class LegalInformationViewModel: LegalInformationViewModelType {
    
    fileprivate let coordinator: LegalInformationCoordinatorType
    private let legalInformationType: LegalInformationType
    private var text: String = ""
    
    init(coordinator: LegalInformationCoordinatorType, legalInformationType: LegalInformationType) {
        self.coordinator = coordinator
        self.legalInformationType = legalInformationType
    }
    
    func getText() -> String {
        switch legalInformationType {
        case .termsAndConditions:
            let text = """
Terms of Service

Please read these Terms of Service carefully before using the Sportly mobile application (the "Service") operated by Sportly Inc.

By accessing or using the Service, you agree to be bound by these Terms. If you disagree with any part of the terms, then you may not access the Service.

1. Content and Betting

Sportly Inc. provides information about sports matches and allows users to place bets on the matches through the Service. The information provided on Sportly is for informational purposes only and should not be considered as professional advice or recommendations. The betting feature is intended for entertainment purposes, and users should only participate if permitted by applicable laws and regulations in their jurisdiction.

2. User Responsibilities

Users of Sportly are solely responsible for their use of the Service and any actions taken based on the information provided. Users should exercise caution and discretion when placing bets and should not engage in any illegal activities or violate any applicable laws or regulations.

3. Accuracy of Information

While we strive to provide accurate and up-to-date information, Sportly Inc. does not warrant the accuracy, completeness, or reliability of any information on the Service. Users should independently verify the information and use it at their own risk.

4. Intellectual Property

The Service and its original content (excluding Content provided by users) are and will remain the exclusive property of Sportly Inc. and its licensors. The Service is protected by copyright, trademark, and other laws. Our trademarks and trade dress may not be used in connection with any product or service without the prior written consent of Sportly Inc.

5. Termination

We may terminate or suspend access to our Service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.

6. Governing Law

These Terms shall be governed and construed in accordance with the laws of Ukraine, without regard to its conflict of law provisions.
"""
            return text
        case .privacyPolicy:
            let text = """
Privacy Policy

Sportly Inc. built the Sportly app as a Free app. This SERVICE is provided by Sportly Inc. at no cost and is intended for use as is.

This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.

If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.

Information Collection and Use

For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to [types of personal information collected]. The information that we request will be retained by us and used as described in this privacy policy.

The app does use third party services that may collect information used to identify you.

Link to privacy policy of third party service providers used by the app

[Third Party Service Provider 1]

[Third Party Service Provider 2]

Log Data

We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.

Cookies

Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

Service Providers

We may employ third-party companies and individuals due to the following reasons:

- To facilitate our Service;
- To provide the Service on our behalf;
- To perform Service-related services; or
- To assist us in analyzing how our Service is used.

We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.

Security

We value your trust in providing us with your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.

Links to Other Sites

This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.

Children’s Privacy

These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions.

Changes to This Privacy Policy

We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page.

Contact Us

If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us.
"""
            return text
        }
    }
    
    
}

enum LegalInformationType {
    case termsAndConditions
    case privacyPolicy
}
