begin
  require 'time_entry_activity'
rescue LoadError
  # TimeEntryActivity is not available
end

# Wrappers around the Redmine core API changes between versions
module BulkTimeEntryCompatibility
  class Enumeration
    # Wrapper around Redmine's API since Enumerations changed in r2472
    # This can be removed once 0.9.0 is stable
    def self.activities
      if Object.const_defined?('TimeEntryActivity')
        return ::TimeEntryActivity.all
      elsif ::Enumeration.respond_to?(:activities)
        return ::Enumeration.activities
      else
        return ::Enumeration::get_values('ACTI')
      end
    end
  end
end
