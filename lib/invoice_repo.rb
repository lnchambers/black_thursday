require_relative 'create_elements'
require_relative 'invoice'

class InvoiceRepo
  include CreateElements

  attr_reader :invoices,
              :parent

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

 def find_all_by_customer_id(id)
   @invoices.values.find_all do |invoice|
     invoice.customer_id == id
   end
 end

 def find_all_by_merchant_id(id)
   @invoices.values.find_all do |invoice|
     invoice.merchant_id == id
   end
 end

 def find_all_by_status(status)
   @invoices.values.find_all do |invoices|
     invoices.status == status
   end
 end

 def find_merchant(id)
   @parent.find_merchants(id)
 end

 def inspect
  "#<#{self.class} #{@invoices.size} rows>"
 end

end
