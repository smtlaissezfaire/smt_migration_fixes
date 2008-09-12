module SMT
  module MigrationFixes
    module MigrationMethods
      def self.extended(other_mod)
        other_mod.instance_eval do
          class << self
            alias_method :old_migrate, :migrate
            
            def migrate(*args, &blk)
              old_migrate(*args, &blk)
              reset_class_information
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
