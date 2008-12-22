require File.dirname(__FILE__) + "/../spec_helper"

module SMT
  describe MigrationFixes do
    describe "version" do
      it "should be at 1.1.0" do
        MigrationFixes::VERSION.should == "1.1.0"
      end
    end
  end
end
