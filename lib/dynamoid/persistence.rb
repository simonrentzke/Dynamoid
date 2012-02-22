require 'securerandom'

# encoding: utf-8
module Dynamoid #:nodoc:

  # This module saves things!
  module Persistence
    extend ActiveSupport::Concern
    
    def save
      self.class.create_table(self.class.table_name) unless self.class.table_exists?(self.class.table_name)
      self.id = SecureRandom.uuid if self.id.nil? || self.id.blank?
      Dynamoid::Adapter.put_item(self.class.table_name, self.attributes)
      save_indexes
    end
    
    module ClassMethods
      def table_name
        "#{Dynamoid::Config.namespace}_#{self.to_s.downcase.pluralize}"
      end
      
      def create_table(table_name, id = :id)
        Dynamoid::Adapter.create_table(table_name, id.to_sym)
      end
      
      def table_exists?(table_name)
        Dynamoid::Adapter.list_tables.include?(table_name)
      end
    end
  end
  
end