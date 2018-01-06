require 'pry'
require_relative 'invoice_repo'

class Invoice

  def initialize(data, repository)
    @id         = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status     = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

end
