module Lotrb
  class BaseResource  
    # The fundamental method for fetching a list of resources from the API.
    def self.list(params = {})
      child_class = self
      path = self::RESOURCE_NAME
      internal_get(path: path, params: params, result_class: child_class)
    end

    # The fundamental method for fetching a specific resource from the API, by ID.
    def self.retrieve(id)
      child_class = self
      path = "#{self::RESOURCE_NAME}/#{id}"
      internal_get(path: path, result_class: child_class).results.first
    end

    # Take a hash that represents an object (from JSON),
    # convert the field names to snake case (to be ruby-ish)
    # and metaprogram those fields onto object, and return it.
    #
    # This is used throughout for taking a single entry from an API result
    # and mapping it into a Ruby object with the fields we might expect.
    # The metaprogramming here allows us to avoid having to explicitly
    # specify the fields we are expecting in the response -- the resulting
    # Ruby object will have all the fields that the response object did.
    def self.from_result_hash(result_hash)
      poro = new
      result_hash.each do |(field_name, field_value)|
        snake_case_field_name = Util.to_snake_case(field_name)
        poro.class.attr_accessor(snake_case_field_name)
        poro.send("#{snake_case_field_name}=", field_value)
      end

      poro
    end

    # All `list`, `retrieve`, and `list_blahs` calls go through this method.
    # Use the API client to get the response (validating the params along the way),
    # then map the results to the right class.
    def self.internal_get(path:, params: {}, result_class:)
      response_body = Client.instance.get(path, params).body
      ListObject.new(response_body, result_class)
    end
  end
end
