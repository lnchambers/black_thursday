require_relative 'similar_attributes'

class InvoiceGen
  include SimilarAttributes

  def initialize
    @id = 0
    @customer_id = customer_id
    @merchant_id = merchant_id
    @status = status
    @created_at = created_at
    @updated_at = updated_at
  end

  def id_setter
    @id += 1
  end


end
