require File.dirname(__FILE__) + "/../spec_helper"

module SMT
  describe MigrationFixes do
    describe "loading" do

      describe "when it hasn't been loaded" do
        before(:each) do
          mod = Module.new do
            def migrate(*args)
              :original_migration_method
            end
          end

          @klass = Class.new do
            extend mod
          end
        end

        it "should call the original migration method" do
          @klass.extend MigrationFixes::MigrationMethods
          @klass.should_receive(:old_migrate)
          @klass.migrate
        end

        it "should return the result of the original method" do
          @klass.extend MigrationFixes::MigrationMethods
          @klass.migrate.should equal(:original_migration_method)
        end

        it "should reset the class information" do
          @klass.extend MigrationFixes::MigrationMethods
          @klass.should_receive(:reset_class_information)
          @klass.migrate
        end
      end

      describe "when it has already been loaded" do
        before(:each) do
          mod = Module.new do
            def migrate(*args)
              :new_migrate
            end

            def old_migrate(*args)
              :old_migrate
            end
          end

          @klass = Class.new do
            extend mod
          end
        end

        it "should not redefine the method if it is already present" do
          @klass.extend MigrationFixes::MigrationMethods
          @klass.old_migrate.should == :old_migrate
        end
      end
    end
  end
end
