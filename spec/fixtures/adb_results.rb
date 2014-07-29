module Fixtures
  class Adb
    class << self
      def test_success
        "\r\ncom.android.activity.resolve.facebook.ResolveTrackDeeplink:.\
\r\nTest results for RandomizingRunner=.\
\r\nTime: 5.873\
\r\n\r\nOK (1 test)\
\r\n\r\n\r\n"
      end

      def test_failure
        "\r\ncom.android.activity.resolve.facebook.ResolveTrackDeeplink:\r\nFailure in testFacebookTrackDeeplink:\r\njunit.framework.ComparisonFailure: expected:<...h other on SoundClou[]> but was:<...h other on SoundClou[d]>\r\n\tat com.android.activity.resolve.facebook.ResolveTrackDeeplink.testFacebookTrackDeeplink(ResolveTrackDeeplink.java:22)\r\n\tat java.lang.reflect.Method.invokeNative(Native Method)\r\n\tat android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)\r\n\tat android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)\r\n\tat android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)\r\n\tat com.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:91)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)\r\n\tat android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)\r\n\tat com.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)\r\n\tat android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)\r\n\r\nTest results for RandomizingRunner=.F\r\nTime: 6.485\r\n\r\nFAILURES!!!\r\nTests run: 1,  Failures: 1,  Errors: 0\r\n\r\n\r\n"
      end

      def test_error
        "\r\ncom.android.activity.resolve.facebook.ResolveTrackDeeplink:\r\nError in testFacebookTrackDeeplink:\r\njava.lang.NullPointerException\r\n\tat com.android.activity.resolve.facebook.ResolveTrackDeeplink.testFacebookTrackDeeplink(ResolveTrackDeeplink.java:22)\r\n\tat java.lang.reflect.Method.invokeNative(Native Method)\r\n\tat android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)\r\n\tat android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)\r\n\tat android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)\r\n\tat com.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:91)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)\r\n\tat android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)\r\n\tat com.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)\r\n\tat android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)\r\n\r\nTest results for RandomizingRunner=.E\r\nTime: 4.314\r\n\r\nFAILURES!!!\r\nTests run: 1,  Failures: 0,  Errors: 1\r\n\r\n\r\n"
      end

      def test_run_error
        "\r\ncom.android.search.Search:INSTRUMENTATION_RESULT: shortMsg=java.lang.NullPointerException\
\r\nINSTRUMENTATION_RESULT: longMsg=java.lang.NullPointerException: An error occured while executing doInBackground()\
\r\nINSTRUMENTATION_CODE: 0\r\n"
      end

      def test_cannot_start_error
        "INSTRUMENTATION_STATUS: id=ActivityManagerService\
\r\nINSTRUMENTATION_STATUS: Error=Unable to find instrumentation info for: ComponentInfo{com.android.tests/com.android.tests.RandomizingRunner}\
\r\nINSTRUMENTATION_STATUS_CODE: -1\
\\r\nandroid.util.AndroidException: INSTRUMENTATION_FAILED: com.android.tests/com.android.tests.RandomizingRunner\
\r\n\tat com.android.commands.am.Am.runInstrument(Am.java:616)\
\r\n\tat com.android.commands.am.Am.run(Am.java:118)\
\r\n\tat com.android.commands.am.Am.main(Am.java:81)\
\r\n\tat com.android.internal.os.RuntimeInit.nativeFinishInit(Native Method)\
\r\n\tat com.android.internal.os.RuntimeInit.main(RuntimeInit.java:235)\
\r\n\tat dalvik.system.NativeStart.main(Native Method)\r\n"
      end

      def test_failure_stack_trace
        "junit.framework.ComparisonFailure: expected:<...h other on SoundClou[]> but was:<...h other on SoundClou[d]>\r\n\tat com.android.activity.resolve.facebook.ResolveTrackDeeplink.testFacebookTrackDeeplink(ResolveTrackDeeplink.java:22)\r\n\tat java.lang.reflect.Method.invokeNative(Native Method)\r\n\tat android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)\r\n\tat android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)\r\n\tat android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)\r\n\tat com.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:91)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)\r\n\tat android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)\r\n\tat com.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)\r\n\tat android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)"
      end

      def test_error_stack_trace
        "java.lang.NullPointerException\r\n\tat com.android.activity.resolve.facebook.ResolveTrackDeeplink.testFacebookTrackDeeplink(ResolveTrackDeeplink.java:22)\r\n\tat java.lang.reflect.Method.invokeNative(Native Method)\r\n\tat android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)\r\n\tat android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)\r\n\tat android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)\r\n\tat com.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:91)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)\r\n\tat android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)\r\n\tat com.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)\r\n\tat android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)"
      end

      def error_message
        "java.lang.NullPointerException: An error occured while executing doInBackground()"
      end

      def passed_negative_time
        "\r\ncom.android.explore.ExploreRecommendations:.\r\nTest results for RandomizingRunner=.\r\nTime: -53.656\r\n\r\nOK (1 test)\r\n\r\n\r\n"
      end
    end
  end
end