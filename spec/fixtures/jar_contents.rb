module Fixtures
  module JarContents
    class << self
      def duplicated_classes
      <<-JAR_CONTENT
com/android/tests/Waiter$1$1.class
com/android/tests/Waiter$1.class
com/android/tests/Waiter$2.class
com/android/tests/Waiter$ByClassCondition.class
com/android/tests/Waiter$DrawerStateCondition.class
com/android/tests/Waiter$NoProgressBarCondition.class
com/android/tests/Waiter$NoTextCondition.class
com/android/tests/Waiter$PlayerPlayingCondition.class
com/android/tests/Waiter$VisibleElementCondition.class
com/android/tests/Waiter.class
      JAR_CONTENT
      end

    end

    def self.multiple_classes
      <<-JAR_CONTENT
com/android/screens/HomeScreen.class
com/android/auth/login/LoginFlowTest.class
      JAR_CONTENT
    end
  end
end
