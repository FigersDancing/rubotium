require 'spec_helper'
describe Rubotium::JarReader do
  let(:jar_reader) {described_class.new("path")}

  context "Given there are no classes in jar" do
    before do
      Rubotium::CMD.stub(:run_command).and_return("")
    end
    it 'should return empty array' do
      jar_reader.get_classes.should be_kind_of Array
      jar_reader.get_classes.should be_empty
    end
  end

  context "Given there are classes in jar" do
    before do
      Rubotium::CMD.stub(:run_command).with("jar -tf path | grep '.class'").and_return(Fixtures::JarContents.multiple_classes)
      Rubotium::CMD.stub(:run_command).with("javap -classpath path com.android.screens.HomeScreen").and_return(
        Fixtures::JavaPClasses.class_with_no_tests
      )

      Rubotium::CMD.stub(:run_command).with("javap -classpath path com.android.auth.login.LoginFlowTest").and_return(
        Fixtures::JavaPClasses.class_with_tests
      )
    end

    it 'should return an array with classes' do
      jar_reader.get_classes.should be_kind_of Array
      jar_reader.get_classes.should_not be_empty
    end

    it 'should convert class names to valid format' do
      jar_reader.get_classes.first.should eql "com.android.screens.HomeScreen"
    end

    it 'should get the pacakges with tests' do
      tests = jar_reader.get_tests
      tests.should have(1).item
    end

    it 'should know the tests per package' do
      tests = jar_reader.get_tests
      tests["com.android.auth.login.LoginFlowTest"].should == [ "testGPlusLoginFlow",
                                                                           "testLoginAndLogout",
                                                                           "testLoginWithFacebookWebFlow",
                                                                           "testLoginWithWrongCredentials",
                                                                           "testNoGooglePlusAccountLogin",
                                                                           "testRecoverPassword",
                                                                           "testRecoverPasswordNoInput",
                                                                           "testSCUserLoginFlow"
                                                                          ]
    end

  end


  context "Given there are duplicated classes in jar" do
    before do
      Rubotium::CMD.stub(:run_command).and_return(Fixtures::JarContents.duplicated_classes)
    end
    it 'deduplicates classess' do
      jar_reader.get_classes.should == ['com.android.tests.Waiter']
    end
  end

end
