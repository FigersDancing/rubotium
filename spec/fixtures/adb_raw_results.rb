module Fixtures
  class AdbRawResults
    class << self
      def multiple_test_results
        "INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=1
INSTRUMENTATION_STATUS: class=com.soundcloud.android.MenuCrashTest
INSTRUMENTATION_STATUS: stream=
com.soundcloud.android.MenuCrashTest:
INSTRUMENTATION_STATUS: numtests=150
INSTRUMENTATION_STATUS: test=testMenuCrash
INSTRUMENTATION_STATUS_CODE: 1
INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=1
INSTRUMENTATION_STATUS: class=com.soundcloud.android.MenuCrashTest
INSTRUMENTATION_STATUS: stream=.
INSTRUMENTATION_STATUS: numtests=150
INSTRUMENTATION_STATUS: test=testMenuCrash
INSTRUMENTATION_STATUS_CODE: 0
INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=2
INSTRUMENTATION_STATUS: class=com.soundcloud.android.StreamTest
INSTRUMENTATION_STATUS: stream=
com.soundcloud.android.StreamTest:
INSTRUMENTATION_STATUS: numtests=150
INSTRUMENTATION_STATUS: test=testStreamContainsItems
INSTRUMENTATION_STATUS_CODE: 1
INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=2
INSTRUMENTATION_STATUS: class=com.soundcloud.android.StreamTest
INSTRUMENTATION_STATUS: stream=.
INSTRUMENTATION_STATUS: numtests=150
INSTRUMENTATION_STATUS: test=testStreamContainsItems
INSTRUMENTATION_STATUS_CODE: -1
INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=3
INSTRUMENTATION_STATUS: class=com.soundcloud.android.StreamTest
INSTRUMENTATION_STATUS: stream=
INSTRUMENTATION_STATUS: numtests=150
INSTRUMENTATION_STATUS: test=testStreamShouldHaveCorrectTitle
INSTRUMENTATION_STATUS_CODE: 1
INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=3
INSTRUMENTATION_STATUS: class=com.soundcloud.android.StreamTest
INSTRUMENTATION_STATUS: stream=.
INSTRUMENTATION_STATUS: numtests=150
INSTRUMENTATION_STATUS: test=testStreamShouldHaveCorrectTitle
INSTRUMENTATION_STATUS_CODE: -2
INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=4
INSTRUMENTATION_STATUS: class=com.soundcloud.android.activities.Activities
INSTRUMENTATION_STATUS: stream=
com.soundcloud.android.activities.Activities:
INSTRUMENTATION_STATUS: numtests=150
INSTRUMENTATION_STATUS: test=testCommentGoesToCommentsScreen
INSTRUMENTATION_RESULT: stream=
Test results for RandomizingRunner=.........................................
.........................................
.........................................
...........................
Time: 0.142

OK (150 tests)"
      end

      def test_cannot_start_error
        "INSTRUMENTATION_STATUS: id=ActivityManagerService
INSTRUMENTATION_STATUS: Error=Unable to find instrumentation info for: ComponentInfo{com.soundcloud.android.tests/com.soundcloud.android.tests.RandomizingRunnr}
INSTRUMENTATION_STATUS_CODE: -1
android.util.AndroidException: INSTRUMENTATION_FAILED: com.soundcloud.android.tests/com.soundcloud.android.tests.RandomizingRunnr
	at com.android.commands.am.Am.runInstrument(Am.java:802)
	at com.android.commands.am.Am.onRun(Am.java:242)
	at com.android.internal.os.BaseCommand.run(BaseCommand.java:47)
	at com.android.commands.am.Am.main(Am.java:75)
	at com.android.internal.os.RuntimeInit.nativeFinishInit(Native Method)
	at com.android.internal.os.RuntimeInit.main(RuntimeInit.java:235)
	at dalvik.system.NativeStart.main(Native Method)"
      end

      def test_run_error
        "INSTRUMENTATION_RESULT: shortMsg=java.lang.RuntimeException
INSTRUMENTATION_RESULT: longMsg=java.lang.RuntimeException: Could not find test class. Class: com.soundcloud.android.MenuCrashTests
INSTRUMENTATION_CODE: 0"
      end

      def app_crashed_during_tests
       "INSTRUMENTATION_STATUS: id=InstrumentationTestRunner
INSTRUMENTATION_STATUS: current=1
INSTRUMENTATION_STATUS: class=com.soundcloud.android.MenuCrashTest
INSTRUMENTATION_STATUS: stream=
com.soundcloud.android.MenuCrashTest:
INSTRUMENTATION_STATUS: numtests=1
INSTRUMENTATION_STATUS: test=testMenuCrash
INSTRUMENTATION_STATUS_CODE: 1
INSTRUMENTATION_RESULT: shortMsg=java.lang.RuntimeException
INSTRUMENTATION_RESULT: longMsg=java.lang.RuntimeException: developer requested crash
INSTRUMENTATION_CODE: 0"
      end

      def single_failed_test
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
INSTRUMENTATION_STATUS_CODE: -2
INSTRUMENTATION_RESULT: stream=
Test results for RandomizingRunner=.F
Time: 16.79

FAILURES!!!
Tests run: 1,  Failures: 1,  Errors: 0"
      end
    end
  end
end

