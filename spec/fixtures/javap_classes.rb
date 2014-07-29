module Fixtures
  module JavaPClasses
    class << self
      def class_with_no_tests
    <<-JAVAP
public class com.android.tests.Waiter extends java.lang.Object{
    public final int NETWORK_TIMEOUT;
    public final int TIMEOUT;
    public com.android.tests.Han solo;
    static {};
    public com.android.tests.Waiter(com.android.tests.Han);
    static java.lang.String access$300();
    public void waitForActivity(java.lang.Class);
    public boolean waitForContentAndRetryIfLoadingFailed();
    public boolean waitForDrawerToClose();
    public boolean waitForDrawerToOpen();
    public boolean waitForElement(int);
    public boolean waitForElement(android.view.View);
    public boolean waitForElement(java.lang.Class);
    public boolean waitForFragmentByTag(java.lang.String);
    public boolean waitForItemCountToIncrease(android.widget.ListAdapter, int);
    public void waitForLogInDialog();
    public boolean waitForPlayerPlaying();
    public void waitForText(java.lang.String);
    public boolean waitForTextToDisappear(java.lang.String);
    public void waitForViewId(int);
    public boolean waitForWebViewToLoad(android.webkit.WebView);
}
    JAVAP
      end

      def class_with_tests
        <<-JAVAP
public class com.android.auth.login.LoginFlowTest extends com.android.auth.LoginTestCase{
    public com.android.auth.login.LoginFlowTest();
    public void ignore_testLoginWithFBApplication();
    public void setUp()       throws java.lang.Exception;
    public void testGPlusLoginFlow();
    public void testLoginAndLogout();
    public void testLoginWithFacebookWebFlow()       throws java.lang.Throwable;
    public void testLoginWithWrongCredentials();
    public void testNoGooglePlusAccountLogin();
    public void testRecoverPassword()       throws java.lang.Throwable;
    public void testRecoverPasswordNoInput();
    public void testSCUserLoginFlow();
}
        JAVAP
      end

    end
  end
end
