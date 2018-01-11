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
   return invoices.values
 end

 def find_by_id(id)
   invoices[id]
 end

 def find_all_by_customer_id(id)
   invoices.values.find_all do |invoice|
     invoice.customer_id == id
   end
 end

 def find_all_by_merchant_id(id)
   invoices.values.find_all do |invoice|
     invoice.merchant_id == id
   end
 end

 def find_all_by_status(status)
   invoices.values.find_all do |invoice|
     invoice.status == status
   end
 end

 def find_merchant(id)
   parent.find_merchants(id)
 end

 def find_all_items(id)
   parent.find_items_for_invoice(id)
 end

 def find_all_invoice_items(id)
   parent.find_all_invoice_items(id)
 end

 def find_all_transactions(id)
   parent.find_transactions_for_invoice(id)
 end

 def find_all_customers(id)
   parent.find_customers_for_invoice(id)
 end

 def pending_invoices
   invoices.values.find_all do |invoice|
     invoice.status == :pending
   end
 end

 def successful_payment?
   invoices.values.reduce({}) do |result, invoice|
     if invoice.is_paid_in_full?
       result.merge({invoice.merchant_id => invoice.total})
     else
       result
     end
   end
 end

 def inspect
   "#<#{self.class} #{invoices.size} rows>"
 end

end
