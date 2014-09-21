module Fixtures
  class AdbRawResult
    class << self
      def successful_test_result
        "INSTRUMENTATION_STATUS_CODE: 1
INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=1
INSTRUMENTATION_STATUS: class=com.soundcloud.android.MenuCrashTest
INSTRUMENTATION_STATUS: stream=.
INSTRUMENTATION_STATUS: numtests=150
INSTRUMENTATION_STATUS: test=testMenuCrash
INSTRUMENTATION_STATUS_CODE: 0"
      end

      def single_failed_test_result
        "INSTRUMENTATION_STATUS_CODE: 9
INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=1
INSTRUMENTATION_STATUS: class=com.soundcloud.android.MenuCrashTest
INSTRUMENTATION_STATUS: stream=
Failure in testMenuCrash:
junit.framework.AssertionFailedError
	at com.soundcloud.android.MenuCrashTest.testMenuCrash(MenuCrashTest.java:22)
	at java.lang.reflect.Method.invokeNative(Native Method)
	at android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)
	at android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)
	at android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)
	at com.soundcloud.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:100)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)
	at android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)
	at com.soundcloud.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)
	at android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)

INSTRUMENTATION_STATUS: numtests=1
INSTRUMENTATION_STATUS: stack=junit.framework.AssertionFailedError
	at com.soundcloud.android.MenuCrashTest.testMenuCrash(MenuCrashTest.java:22)
	at java.lang.reflect.Method.invokeNative(Native Method)
	at android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)
	at android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)
	at android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)
	at com.soundcloud.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:100)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)
	at android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)
	at com.soundcloud.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)
	at android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)

INSTRUMENTATION_STATUS: test=testMenuCrash
INSTRUMENTATION_STATUS_CODE: -2"
      end

      def single_failed_test_stack_trace
        "junit.framework.AssertionFailedError
	at com.soundcloud.android.MenuCrashTest.testMenuCrash(MenuCrashTest.java:22)
	at java.lang.reflect.Method.invokeNative(Native Method)
	at android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)
	at android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)
	at android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)
	at com.soundcloud.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:100)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)
	at android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)
	at com.soundcloud.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)
	at android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)"
      end

      def single_errored_test_result
        "INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=1
INSTRUMENTATION_STATUS: class=com.soundcloud.android.MenuCrashTest
INSTRUMENTATION_STATUS: stream=
com.soundcloud.android.MenuCrashTest:
INSTRUMENTATION_STATUS: numtests=1
INSTRUMENTATION_STATUS: test=testMenuCrash
INSTRUMENTATION_STATUS_CODE: 1
INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=1
INSTRUMENTATION_STATUS: class=com.soundcloud.android.MenuCrashTest
INSTRUMENTATION_STATUS: stream=
Error in testMenuCrash:
java.lang.NullPointerException
	at com.soundcloud.android.MenuCrashTest.testMenuCrash(MenuCrashTest.java:21)
	at java.lang.reflect.Method.invokeNative(Native Method)
	at android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)
	at android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)
	at android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)
	at com.soundcloud.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:102)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)
	at android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)
	at com.soundcloud.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)
	at android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)

INSTRUMENTATION_STATUS: numtests=1
INSTRUMENTATION_STATUS: stack=java.lang.NullPointerException
	at com.soundcloud.android.MenuCrashTest.testMenuCrash(MenuCrashTest.java:21)
	at java.lang.reflect.Method.invokeNative(Native Method)
	at android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)
	at android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)
	at android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)
	at com.soundcloud.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:102)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)
	at android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)
	at com.soundcloud.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)
	at android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)

INSTRUMENTATION_STATUS: test=testMenuCrash
INSTRUMENTATION_STATUS_CODE: -1"
      end

      def single_errored_test_result_stack_trace
        "java.lang.NullPointerException
	at com.soundcloud.android.MenuCrashTest.testMenuCrash(MenuCrashTest.java:21)
	at java.lang.reflect.Method.invokeNative(Native Method)
	at android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)
	at android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)
	at android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)
	at com.soundcloud.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:102)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)
	at android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)
	at android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)
	at com.soundcloud.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)
	at android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)"
      end

      def such_error_wow
        "INSTRUMENTATION_STATUS_CODE: 1\r\nINSTRUMENTATION_STATUS: numtests=1\r\nINSTRUMENTATION_STATUS: stream=\r\nError in testMenuCrash:\r\njava.lang.NullPointerException\r\n\tat com.soundcloud.android.MenuCrashTest.testMenuCrash(MenuCrashTest.java:21)\r\n\tat java.lang.reflect.Method.invokeNative(Native Method)\r\n\tat android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)\r\n\tat android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)\r\n\tat android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)\r\n\tat com.soundcloud.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:102)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)\r\n\tat android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)\r\n\tat com.soundcloud.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)\r\n\tat android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)\r\n\r\nINSTRUMENTATION_STATUS: id=InstrumentationTestRunner\r\nINSTRUMENTATION_STATUS: test=testMenuCrash\r\nINSTRUMENTATION_STATUS: class=com.soundcloud.android.MenuCrashTest\r\nINSTRUMENTATION_STATUS: stack=java.lang.NullPointerException\r\n\tat com.soundcloud.android.MenuCrashTest.testMenuCrash(MenuCrashTest.java:21)\r\n\tat java.lang.reflect.Method.invokeNative(Native Method)\r\n\tat android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)\r\n\tat android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)\r\n\tat android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)\r\n\tat com.soundcloud.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:102)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)\r\n\tat android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)\r\n\tat com.soundcloud.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)\r\n\tat android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)\r\n\r\nINSTRUMENTATION_STATUS: current=1\r\nINSTRUMENTATION_STATUS_CODE: -1"
      end

      def such_error_stack_trace
        "java.lang.NullPointerException\r\n\tat com.soundcloud.android.MenuCrashTest.testMenuCrash(MenuCrashTest.java:21)\r\n\tat java.lang.reflect.Method.invokeNative(Native Method)\r\n\tat android.test.InstrumentationTestCase.runMethod(InstrumentationTestCase.java:214)\r\n\tat android.test.InstrumentationTestCase.runTest(InstrumentationTestCase.java:199)\r\n\tat android.test.ActivityInstrumentationTestCase2.runTest(ActivityInstrumentationTestCase2.java:192)\r\n\tat com.soundcloud.android.tests.ActivityTestCase.runTest(ActivityTestCase.java:102)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:191)\r\n\tat android.test.AndroidTestRunner.runTest(AndroidTestRunner.java:176)\r\n\tat android.test.InstrumentationTestRunner.onStart(InstrumentationTestRunner.java:554)\r\n\tat com.soundcloud.android.tests.RandomizingRunner.onStart(RandomizingRunner.java:11)\r\n\tat android.app.Instrumentation$InstrumentationThread.run(Instrumentation.java:1701)"
      end
    end
  end
end

