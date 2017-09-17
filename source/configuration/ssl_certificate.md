title: Get And Install SSL Certificate
---

> If you are willing to help hiproxy to write documentation, please contact zdying@live.com, thank you!

Hiproxy can generate its own root certificate. You can think it as a CA (Hiproxy Custom CA). If a https request need hiproxy to forward, hiproxy would use its own root certificate to generate automatically a secure certification of that https request.

Hiproxy own root certificate is not trusted by OS, therefore, you have to install the root certificate by manual to let OS know it as trusted one.

## Download The Certificate

As soon as hiproxy is started (suppose the port number is `5525`), you can go <http://127.0.0.1:5525/ssl-certificate> to get the root certificate of **Hiproxy Custom CA**.

You can get the URL from <http://127.0.0.1:5525/> by following below image:

<img src="../../images/hiproxy_start_page.png" width="500" />

## Install Certificate

The following describes how the root certificate is installed in OSX, iOS, Windows and Android.

### Mac OSX

1. Double click downloaded `Hiproxy_Custom_CA_Certificate.pem` to import the certificate to keychain.

2. Input your username and password in popuped dialog.

3. Now the certificate is not trusted. You should double click the certificate which is imported in previous step.

<img src="../../images/import_root_cert.png" width="680" />

4. Choose ** Always trust** by following **Trust** > **While using this certificate**.

<img src="../../images/trust_root_cert.png" width="680" />

5. Close the dialog. Now the certificate is in trusted state.

<img src="../../images/root_cert_trusted.png" width="680" />


### iOS

1. Send the downloaded certificate to iPhone then open it in iOS.

2. Click **Install** on the top right of the view.

<img src="../../images/ios_install_cert_1.jpg" width="375" />

3. Click **Install** to confirm.

<img src="../../images/ios_install_cert_2.jpg" width="375" />

4. After complate installing, click **Complete** to finish and exit installing.

<img src="../../images/ios_install_cert_3.jpg" width="375" />

5. If the **iOS version &gt;= 10.3**, you have to click **Certificate trust settings** by following **Settings** &gt; **General** &gt; **About this iPhone**.

<img src="../../images/ios_install_cert_4.jpg" width="375" />

6. Open the switcher on **Hiproxy Custom CA**.

<img src="../../images/ios_install_cert_5.jpg" width="375" />

### Windows

1. Double click downloaded  `Hiproxy_Custom_CA_Certificate.crt` to install the certificate.

2. Click **Install certificate** on the popuped dialog.

<img src="../../images/windows_install_cert.png" width="420" />

3. Click **Next**.

<img src="../../images/windows_step_1.png" width="420" />

4. Choose **Persist all certificates in below storage(P)** then click **Browse(R)** and select **Trusted CA**, click **OK**

<img src="../../images/windows_step_2.png" width="420" />

5. Click **Next**, then **Finish**. Complete the certificate installing by following wizard.

<img src="../../images/windows_install_finish.png" width="420" />


### Android

1. Download the certificate and send it to mobile.

2. Click **Install from SD card** by following **Settings** &gt; **Security**.

<img src="../../images/android_install_cert_1.png" width="375" />

3. Input the unlock password then certificate name, for example **HiproxyCustomCA**, then click **OK**.

<img src="../../images/android_install_cert_2.png" width="375" />

4. Follow **Settings** &gt; **Security** &gt; **Trusted certificate** &gt; **Users**. If you can find hiproxy root certificate, it succeeds.

<img src="../../images/android_install_cert_3.png" width="375" />
