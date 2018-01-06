require_relative 'create_elements'
require_relative 'invoice'

class InvoiceRepo
  include CreateElements

  def initialize(data, parent)
    @invoices = {}
    create_elements(data).each do |row|
      @invoices[row[:id].to_i] = Invoice.new(row, self)
    end
    @parent = parent
  end

  def all
    return @invoices.values
  end

  def find_by_id(id)
    @invoices[id]
  end

end
