class Strings {
  static const appName = "Audifie";

  // Fonts
  static const comfortaaFont = "Comfortaa-VariableFont_wght";

  // Assets relative path
  static const audifieIcon = "assets/icons/audifie_logo.svg";
  static const audifieTextIcon = "assets/icons/audifie_text_logo.svg";
  static const googleIcon = "assets/icons/google_logo.svg";
  static const facebookIcon = "assets/icons/facebook_logo.svg";
  static const homeIcon = "assets/icons/home.svg";
  static const libraryIcon = "assets/icons/library.svg";
  static const premiumIcon = "assets/icons/premium.svg";
  static const settingsIcon = "assets/icons/settings.svg";
  static const uploadIcon = "assets/icons/upload.svg";
  static const uploadIllustraion = "assets/icons/upload_illustraion.svg";
  static const favouriteIcon = "assets/icons/favourite.svg";
  static const favouriteOutlineIcon = "assets/icons/favourite_outline.svg";
  static const logoutIcon = "assets/icons/LogoutIcon.svg";
  static const aboutIcon = "assets/icons/AboutIcon.svg";
  static const privacyIcon = "assets/icons/PrivacyIcon.svg";
  static const supportIcon = "assets/icons/SupportIcon.svg";
  static const historyIcon = "assets/icons/HistoryIcon.svg";
  static const passwordIcon = "assets/icons/PasswordIcon.svg";
  static const editIcon = "assets/icons/EditIcon.svg";
  static const closeIcon = "assets/icons/CloseIcon.svg";
  static const deleteIcon = "assets/icons/DeleteIcon.svg";
  static const downloadIcon = "assets/icons/DownloadIcon.svg";
  static const emailIcon = "assets/icons/emailIcon.svg";
  static const linkedInIcon = "assets/icons/linkedInLogo.svg";
  static const twitterIcon = "assets/icons/twitterLogo.svg";
  static const clearIcon = "assets/icons/clearIcon.svg";
  static const surpriseBoxGif = "assets/images/surprisebox.gif";
  static const voiceChangeIcon = "assets/icons/voice_change.svg";

  // Success
  static const otpSent = 'OTP sent to email';
  static const resentOtp = 'OTP has been resent to your email';
  static const passwordChanged = "Password changed successfully";
  static const docUploaded = "Document uploaded successfully";
  static const passwordReset = "Password reset successfully";
  static const downalodSuccessful = "File downloaded successful";
  static const sendEmailSuccess = 'Email sent';
  static const signUpSuccess = 'Signed up successfully';
  static const signInSuccess = 'Signed in successfully';

  // Errors
  static const signUpFailure = 'Failed to sign up';
  // Sign in errors
  static const emailInvalid = 'Invalid email';
  static const passwordInvalid = 'Invalid password';
  static const passwordMustContain = 'Password must be atleast 8 chars long';
  static const emailPassNotCorrect = "Email and Password does not match";
  static const confirmPasswordPasswordShouldSame =
      'Confirm password and Password should be same';
  static const commonError = 'There was some error. Please try again';
  // Otp Errors
  static const otpNotFull = "OTP must be of 6 digits";
  static const otpInvalid = "Invalid OTP";
  static const otpNotCorrect = "OTP does not match";
  // Amplify Errors
  static const amplifyAlreadyConfigured =
      "Tried to reconfigure Amplify; this can occur when your app restarts on Android";
  // URL Errors
  static const urlError = "Could not launch URL. Please try again.";
  // Change Password Errors
  static const oldPasswordNotCorrect = "Entered old password is not correct";
  static const passwordCantContainSpace =
      "Password can not contain empty space";
  static const oldPasswordNewPasswordCantSame =
      "Old password and new password can not be same";
  // Audio Errors
  static const setUpAudioError =
      "Unable to setup audio. Please restart the app";
  // Fetching Errors
  static const fetchingError =
      "There was some problem in fetching data. Please restart the app";
  // File picker Errors
  static const fileNotPicked = "File not picked";
  // POST fetching error
  static const postFetchingError = "Failed to fetch audio. Please try again";
  // Download error
  static const downloadError = "Failed to download file. Please try again";
  // Delete error
  static const deleteError = "Failed to delete file. Please try again";
  // Send email error
  static const sendEmailFailure = 'Failed to send email';

  // Instructions
  static const nameCantEmpty = "Name field can not be empty";
  static const emailCantEmpty = "Email field can not be empty";
  static const passwordCantEmpty = "Password field can not be empty";
  static const confirmPasswordCantEmpty = "Field can not be empty";
  static const fieldCantEmpty = "Field can not be empty";
  static const processingTrySomeTime =
      "Document processing. Please retry after some time";
  static const grantStoragePermission =
      "Grant storage permission for downloading file";
  static const enterOtp = 'Please enter OTP';
  static const tryAgain = 'Please try again';

  // API links
  static const apiSignUp = 'http://3.109.49.60:8080/api/users/signup';
  static const apiVerifyEmail =
      'http://3.109.49.60:8080/api/users/verify-email';
  static const apiLogin = 'http://3.109.49.60:8080/api/users/login';
  static const apiGoogleLogin =
      'http://3.109.49.60:8080/api/users/googlesignup';
  static const apiFacebookLogin = 'http://3.109.49.60:8080/api/users/fbsignup';
  static const apiCurrentUser = 'http://3.109.49.60:8080/api/users/current';
  static const apiLogout = 'http://3.109.49.60:8080/api/users/logout';
  static const apiGetAllDocs = 'http://3.109.49.60:8080/api/documents';
  static const apiFavourite = 'http://3.109.49.60:8080/api/documents/edit/';
  static const apiDeleteDoc = 'http://3.109.49.60:8080/api/documents/delete/';
  static const apiUploadDoc = 'http://3.109.49.60:8080/api/documents/upload';
  // static const userFilesAPILink =
  //     "https://gt8u1r94bf.execute-api.ap-south-1.amazonaws.com/dev/userfiles";
  // static const allFilesAPILink =
  //     "https://gt8u1r94bf.execute-api.ap-south-1.amazonaws.com/dev/allfiles";
  // static const favAPILink =
  //     "https://gt8u1r94bf.execute-api.ap-south-1.amazonaws.com/dev/favourite";

  // Local storage keys
  static const keyAccessToken = 'accessToken';

  // Mics
  static const lorem =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Non arcu, dui neque viverra lacus nulla. Ac nisi, mauris ultricies sit. Sed mattis consectetur dictumst ut tortor bibendum Lorem ipsum dolor sit amet, consectetur adipiscing elit. Non arcu, dui neque viverra lacus nulla. Ac nisi, mauris ultricies sit. Sed mattis consectetur dictumst ut tortor bibendum. Faucibus consectetur amet euismod ultricies at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Non arcu, dui neque viverra lacus nulla. Ac nisi, mauris ultricies sit. Sed mattis consectetur dictumst ut tortor bibendum. Faucibus consectetur amet euismod ultricies at";
  static const allowedExtensions = ["pdf", "jpg", "jpeg", "png"];
  static const downloadStarted = "Download started";
  static const noFileToDownload = "No file to download";
  static const filePathsBox = "filePaths";
  static const unableToShowFile = "Unable to show file. Please try again.";
  static const pleaseTryAgain = "Please try again";
  static const privacyPolicy = """
At Audifie, accessible from www.audifie.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Audifie and how we use it.We value the trust you place in us. That’s why we insist upon the highest standards for secure transactions and customer information privacy. Please read the following statement to learn about our information gathering and dissemination practices.Note: Our privacy policy is subject to change at any time without notice. To make sure you are aware of any changes, please review this policy periodically.
  
If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.
  
This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in Audifie. This policy is not applicable to any information collected offline or via channels other than this website. Our Privacy Policy was created with the help of the Online Generator of Privacy Policy.

Consent

By using our website, you hereby consent to our Privacy Policy and agree to its terms.

Information we collect

The personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information.

If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide.

When you register for an Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number.

How we use your information

We use the information we collect in various ways, including to:

  - Provide, operate, and maintain our website
  - Improve, personalize, and expand our website
  - Understand and analyze how you use our website
  - Develop new products, services, features, and 
    functionality
  - Communicate with you, either directly or through
    one of our partners, including for customer service,
    to provide you with updates and other information
    relating to the website, and for marketing
    and promotional purposes
  - Send you emails
  - Find and prevent fraud

Log Files

Audifie follows a standard procedure of using log files. These files log visitors when they visit websites. All hosting companies do this and a part of hosting services' analytics. The information collected by log files include internet protocol (IP) addresses, browser type, Internet Service Provider (ISP), date and time stamp, referring/exit pages, and possibly the number of clicks. These are not linked to any information that is personally identifiable. The purpose of the information is for analyzing trends, administering the site, tracking users' movement on the website, and gathering demographic information.

Cookies and Web Beacons

Like any other website, Audifie uses 'cookies'. These cookies are used to store information including visitors' preferences, and the pages on the website that the visitor accessed or visited. The information is used to optimize the users' experience by customizing our web page content based on visitors' browser type and/or other information.

For more general information on cookies, please read "What Are Cookies" from Cookie Consent.

Our Advertising Partners

Some of advertisers on our site may use cookies and web beacons. Our advertising partners are listed below. Each of our advertising partners has their own Privacy Policy for their policies on user data. For easier access, we hyperlinked to their Privacy Policies below.

  - Google
    https://policies.google.com/technologies/ads

Advertising Partners Privacy Policies

You may consult this list to find the Privacy Policy for each of the advertising partners of Audifie.

Third-party ad servers or ad networks uses technologies like cookies, JavaScript, or Web Beacons that are used in their respective advertisements and links that appear on Audifie, which are sent directly to users' browser. They automatically receive your IP address when this occurs. These technologies are used to measure the effectiveness of their advertising campaigns and/or to personalize the advertising content that you see on websites that you visit.

Note that Audifie has no access to or control over these cookies that are used by third-party advertisers.

Third Party Privacy Policies

Audifie's Privacy Policy does not apply to other advertisers or websites. Thus, we are advising you to consult the respective Privacy Policies of these third-party ad servers for more detailed information. It may include their practices and instructions about how to opt-out of certain options.

You can choose to disable cookies through your individual browser options. To know more detailed information about cookie management with specific web browsers, it can be found at the browsers' respective websites.

CCPA Privacy Rights (Do Not Sell My Personal Information)

Under the CCPA, among other rights, California consumers have the right to:

Request that a business that collects a consumer's personal data disclose the categories and specific pieces of personal data that a business has collected about consumers.

Request that a business delete any personal data about the consumer that a business has collected.

Request that a business that sells a consumer's personal data, not sell the consumer's personal data.

If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us.

GDPR Data Protection Rights

We would like to make sure you are fully aware of all of your data protection rights. Every user is entitled to the following:

The right to access – You have the right to request copies of your personal data. We may charge you a small fee for this service.

The right to rectification – You have the right to request that we correct any information you believe is inaccurate. You also have the right to request that we complete the information you believe is incomplete.

The right to erasure – You have the right to request that we erase your personal data, under certain conditions.

The right to restrict processing – You have the right to request that we restrict the processing of your personal data, under certain conditions.

The right to object to processing – You have the right to object to our processing of your personal data, under certain conditions.

The right to data portability – You have the right to request that we transfer the data that we have collected to another organization, or directly to you, under certain conditions.

If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us.

Children's Information

Another part of our priority is adding protection for children while using the internet. We encourage parents and guardians to observe, participate in, and/or monitor and guide their online activity.

Audifie does not knowingly collect any Personal Identifiable Information from children under the age of 13. If you think that your child provided this kind of information on our website, we strongly encourage you to contact us immediately and we will do our best efforts to promptly remove such information from our records.
  """;

  static const disclaimer = """
Audifie does not provide any warranties, express or implied, or make any representations regarding the use, or the results of use, of CONTENT, in terms of its correctness, legality, decency, accuracy, reliability, appropriateness or otherwise. Review and use of CONTENT are subject to all applicable laws and regulations and is solely at the risk of the individual or organization using this data. Audifie MAKES NO REPRESENTATIONS ABOUT THE SUITABILITY, RELIABILITY, AVAILABILITY, TIMELINESS, LACK OF VIRUSES OR OTHER HARMFUL COMPONENTS AND ACCURACY OF THE INFORMATION, SOFTWARE, PRODUCTS, SERVICES, GRAPHICS AND ANY OTHER MATERIAL AND CONTENT THAT YOU ACCESS VIA THE "SERVICE" FOR ANY PURPOSE. ALL SUCH INFORMATION, SOFTWARE, PRODUCTS, SERVICES, GRAPHICS, AND ANY OTHER MATERIAL AND CONTENT ARE PROVIDED ";AS IS"; WITHOUT WARRANTY OF ANY KIND. YOU EXPRESSLY UNDERSTAND AND AGREE THAT: a. YOUR USE OF THE "SERVICE" IS AT YOUR SOLE RISK. THE "SERVICE" IS PROVIDED ON AN "AS IS" AND "AS AVAILABLE" BASIS. Audifie EXPRESSLY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. b. Audifie MAKES NO WARRANTY THAT (i) THE "SERVICE" WILL MEET YOUR REQUIREMENTS, (ii) THE "SERVICE" WILL BE UNINTERRUPTED, TIMELY, SECURE, OR ERROR-FREE, (iii) THE RESULTS THAT MAY BE OBTAINED FROM THE USE OF THE"SERVICE" WILL BE ACCURATE OR RELIABLE, (iv) THE QUALITY OF ANY PRODUCTS, SERVICES, INFORMATION, OR OTHER MATERIAL PURCHASED OR OBTAINED BY YOU THROUGH THE "SERVICE" WILL MEET YOUR EXPECTATIONS, (v) ANY ERRORS IN THE SOFTWARE WILL BE CORRECTED, (vi) THE "CONTENT" OR ANY INFORMATION, SOFTWARE, PRODUCTS, SERVICES, GRAPHICS AND ANY OTHER MATERIAL DELIVERED TO YOU VIA THE "SERVICE" WILL HAVE NO VIRUSES OR OTHER HARMFUL COMPONENTS, AND (vii) THE USE OF USERNAMES, PASSWORDS, COOKIES AND OTHER DESIGN ELEMENTS OF THE WEBSITE WILL BE SECURE AND IMMUNE FROM SECURITY THREATS.c. THE USE OF COOKIES, USERNAMES AND PASSWORDS ON THE WEBSITE; YOUR PROVISION OF PERSONAL AND CONFIDENTIAL INFORMATION SUCH AS HOME ADDRESS, EMPLOYER INFORMATION, AND E-MAIL ADDRESSES; PLUS ALL OTHER FEATURES OF THIS WEBSITE INCLUDING, BUT NOT LIMITED TO, THE "REMEMBER ME" FACILITY : ANY AND ALL OF THESE FEATURES AND FACILITIES COULD POTENTIALLY EXPOSE YOU AND YOUR COMPUTER TO SECURITY THREATS. YOU SHOULD CONSIDER THESE RISKS BEFORE MAKING A DECISION TO ACCESS THIS WEBSITE AND ITS "CONTENT", AND TO USING ANY OF THE "SERVICES", ALL OF WHICH ARE PROVIDED SOLELY AT YOUR RISK.d. ANY "CONTENT" OR OTHER MATERIAL DOWNLOADED OR OTHERWISE OBTAINED THROUGH THE USE OF THE "SERVICE" IS DONE AT YOUR DISCRETION AND RISK AND THAT YOU WILL BE SOLELY RESPONSIBLE FOR ANY DAMAGE TO YOUR COMPUTER SYSTEM OR LOSS OF DATA Audifie A THAT RESULTS FROM THE DOWNLOAD OF ANY SUCH MATERIAL. e. NO ADVICE OR INFORMATION, WHETHER ORAL OR WRITTEN, OBTAINED BY YOU FROM OR THROUGH OR FROM THE "SERVICE" SHALL CREATE ANY WARRANTY.YOU EXPRESSLY UNDERSTAND AND AGREE THAT Audifie SHALL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL OR EXEMPLARY DAMAGES, INCLUDING BUT NOT LIMITED TO, DAMAGES FOR LOSS OF PROFITS, GOODWILL, USE, DATA OR OTHER INTANGIBLE LOSSES (EVEN IF Audifie.IN HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES), RESULTING FROM: (i) THE USE OR THE INABILITY TO USE THE "SERVICE"; (ii) THE COST OF PROCUREMENT OF SUBSTITUTE GOODS AND SERVICES RESULTING FROM ANY GOODS, DATA, INFORMATION OR SERVICES PURCHASED OR OBTAINED OR MESSAGES RECEIVED OR TRANSACTIONS ENTERED INTO THROUGH OR FROM THE "SERVICE"; (iii) UNAUTHORIZED ACCESS TO OR ALTERATION OF YOUR TRANSMISSIONS OR DATA; (iv) STATEMENTS OR CONDUCT OF ANY THIRD PARTY ON THE "SERVICE"; OR (v) ANY OTHER MATTER RELATING TO THE"SERVICE".All materials are available at Audifie are contributed by users, and the ownership and copyright to the materials remain with the actual owner of the content. Audifie does not claim ownership of any materials or Intellectual Property.Materials shared at Audifie.in are available for educational purposes only. No claim for the originality of content is made. The contents are shared by the users to help other community members.
""";

  static const copyRightPolicy = """
All pages, data, and graphics presented on this website are the property of Audife. or the Author of the content as specified. The pages and contents may not be redistributed or reproduced in any way, shape, or form without the written permission of Audifie. or the Author of the content. Audifie respects the copyrights, trademarks and intellectual property of others and we expect this from other users. If you find any information that is owned by you or any content that violates your intellectual property rights, please contact us at support@audifie.com with all necessary documents/information that authenticates your authority on your property.For all other policies, please read our Terms of use.
""";

  static const termsAndConditions = """
Welcome to Audifie!

These terms and conditions outline the rules and regulations for the use of Audifie's Website, located at www.audifie.com.

By accessing this website we assume you accept these terms and conditions. Do not continue to use Audifie if you do not agree to take all of the terms and conditions stated on this page.

The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: "Client", "You" and "Your" refers to you, the person log on this website and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.

Cookies

We employ the use of cookies. By accessing Audifie, you agreed to use cookies in agreement with the Audifie's Privacy Policy.

Most interactive websites use cookies to let us retrieve the user’s details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies.

License

Unless otherwise stated, Audifie and/or its licensors own the intellectual property rights for all material on Audifie. All intellectual property rights are reserved. You may access this from Audifie for your own personal use subjected to restrictions set in these terms and conditions.

You must not:

  - Republish material from Audifie
  - Sell, rent or sub-license material from Audifie
  - Reproduce, duplicate or copy material from Audifie
  - Redistribute content from Audifie

This Agreement shall begin on the date hereof. Our Terms and Conditions were created with the help of the Terms And Conditions Generator and the Privacy Policy Generator.

Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. Audifie does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of Audifie,its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Audifie shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.

Audifie reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.

You warrant and represent that:

  - You are entitled to post the Comments on our
    website and have all necessary licenses and
    consents to do so;
  - The Comments do not invade any intellectual
    property right, including without limitation copyright,
    patent or trademark of any third party;
  - The Comments do not contain any defamatory,
    libelous, offensive, indecent or otherwise unlawful
    material which is an invasion of privacy
  - The Comments will not be used to solicit or
    promote business or custom or present commercial
    activities or unlawful activity.

You hereby grant Audifie a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.

Hyperlinking to our Content

The following organizations may link to our Website without prior written approval:

  - Government agencies;
  - Search engines;
  - News organizations;
  - Online directory distributors may link to our Website
    in the same manner as they hyperlink to the
    Websites of other listed businesses; and
  - System wide Accredited Businesses except
    soliciting non-profit organizations, charity shopping
    malls, and charity fundraising groups which may
    not hyperlink to our Web site.

These organizations may link to our home page, to publications or to other Website information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party’s site.

We may consider and approve other link requests from the following types of organizations:

  - commonly-known consumer and/or business 
    information sources;
  - dot.com community sites;
  - associations or other groups representing charities;
  - online directory distributors;
  - internet portals;
  - accounting, law and consulting firms; and
  - educational institutions and trade associations.

We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of Audifie; and (d) the link is in the context of general resource information.

These organizations may link to our home page so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party’s site.

If you are one of the organizations listed in paragraph 2 above and are interested in linking to our website, you must inform us by sending an e-mail to Audifie. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our Website, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.

Approved organizations may hyperlink to our Website as follows:

  - By use of our corporate name; or
  - By use of the uniform resource locator being linked
    to; or
  - By use of any other description of our Website
    being linked to that makes sense within the context
    and format of content on the linking party’s site.

No use of Audifie's logo or other artwork will be allowed for linking absent a trademark license agreement.

iFrames

Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our Website.

Content Liability

We shall not be hold responsible for any content that appears on your Website. You agree to protect and defend us against all claims that is rising on your Website. No link(s) should appear on any Website that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.

Your Privacy

Please read Privacy Policy

Reservation of Rights

We reserve the right to request that you remove all links or any particular link to our Website. You approve to immediately remove all links to our Website upon request. We also reserve the right to amen these terms and conditions and it’s linking policy at any time. By continuously linking to our Website, you agree to be bound to and follow these linking terms and conditions.

Removal of links from our website

If you find any link on our Website that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.

We do not ensure that the information on this website is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the website remains available or that the material on the website is kept up to date.
""";

  // Mocks
  // TODO: Delete this when recepients email has come
  static const tempRecipientEmail = "dhritiman.roy.dev@gmail.com";
  static const audioURL1 =
      "http://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3";
  static const audioURL2 =
      "http://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg";
  static const pdf1 = "http://www.africau.edu/images/default/sample.pdf";
  static const img1 =
      "https://i.pinimg.com/originals/f4/2e/bf/f42ebf98a9c13464aaf2593154dc4dd7.png";
}
