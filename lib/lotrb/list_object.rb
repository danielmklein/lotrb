module Lotrb
  # A data structure to hold list results from an API request
  # `results` holds the actual POROs representing the data,
  # while `total`, `limit`, `offset`, `page`, and `pages`
  # hold the corresponding pagination values from the API.
  class ListObject
    attr_reader :results, :total, :limit, :offset, :page, :pages
  
    def initialize(result, klass)
      @total = result["total"]
      @limit = result["limit"]
      @offset = result["offset"]
      @page = result["page"]
      @pages = result["pages"]
      @results = result["docs"].map do |hash|
        klass.from_result_hash(hash)
      end
    end
  end
end
