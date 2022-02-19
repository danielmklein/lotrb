module Lotrb
  class Movie < BaseResource
    RESOURCE_NAME = "movie"

    def list_quotes(params = {})
      child_class = Quote
      path = "#{RESOURCE_NAME}/#{_id}/#{child_class::RESOURCE_NAME}"
      self.class.internal_get(path: path, params: params, result_class: child_class)
    end
  end
end
