module Exposure
  def self.included(base)
    base.class_eval do
      class << self
        def table_name
          class_of_active_record_descendant(self, false).
            table_name
        end

        protected
        def class_of_active_record_descendant(klass, direct=true)
          if direct
            self
          else
            super(klass.superclass)
          end
        end

        def descends_from_active_record?
          true
        end
      end
    end
  end
end