module Lotrb
  class ListObject
    attr_reader :objects, :total, :limit, :offset, :page, :pages
  
    def initialize(result, klass)
      @total = result["total"]
      @limit = result["limit"]
      @offset = result["offset"]
      @page = result["page"]
      @pages = result["pages"]
      @objects = result["docs"].map do |hash|
        klass.from_result_hash(hash)
      end
    end
  end
end
