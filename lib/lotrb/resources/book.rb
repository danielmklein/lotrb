module Lotrb
  class Book < BaseResource
    RESOURCE_NAME = "book"

    def list_chapters(params = {})
      child_class = Chapter
      path = "#{RESOURCE_NAME}/#{_id}/#{child_class::RESOURCE_NAME}"
      self.class.internal_get(path: path, params: params, result_class: child_class)
    end
  end
end
