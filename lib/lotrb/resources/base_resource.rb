module Lotrb
  class BaseResource
    def self.list
      ListObject.new(Client.instance.get(self::RESOURCE_NAME).body, self)
    end

    def self.retrieve(id)
      path = "#{self::RESOURCE_NAME}/#{id}"
      ListObject.new(Client.instance.get(path).body, self).objects.first
    end

    # Take a hash that represents an object (from JSON),
    # convert the field names to snake case (to be ruby-ish)
    # and metaprogram those fields onto object, and return it.
    def self.from_result_hash(result_hash)
      object = new
      result_hash.each do |(field_name, field_value)|
        snake_case_field_name = Util.to_snake_case(field_name)
        object.class.attr_accessor(snake_case_field_name)
        object.send("#{snake_case_field_name}=", field_value)
      end

      object
    end
  end
end