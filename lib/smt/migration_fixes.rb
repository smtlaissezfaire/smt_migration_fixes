# SMTMigrationExtensions  Copyright (C) 2008 Scott Taylor <scott@railsnewbie.com>
module SMT
  module MigrationFixes
    
    MAJOR = 1
    MINOR = 1
    TINY  = 0
    
    VERSION = "#{MAJOR}.#{MINOR}.#{TINY}"
    
    module MigrationMethods
      def self.extended(other_mod)
        other_mod.instance_eval do
          class << self
            unless instance_methods.include?("old_migrate")
              alias_method :old_migrate, :migrate
            
              def migrate(*args, &blk)
                result = old_migrate(*args, &blk)
                reset_class_information
                result
              end
            end
          end
        end
      end
      
      private
      
      def reset_class_information
        ActiveRecord::Base.reset_all_subclasses_column_information
      end
    end
    
    module ARBaseClassMethods
      def reset_all_subclasses_column_information
        subclasses.each do |klass| 
          begin
            klass.reset_column_information 
          rescue
            nil
          end
        end
      end
    end
  end
end
