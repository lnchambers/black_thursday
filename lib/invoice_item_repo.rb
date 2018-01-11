require_relative 'invoice_item'
require_relative 'create_elements'

class InvoiceItemRepo
 attr_reader :invoice_items,
             :parent

 include CreateElements

 def initialize(data, parent)
   @invoice_items = {}
   create_elements(data).each do |row|
     @invoice_items[row[:id].to_i] = InvoiceItem.new(row, self)
   end
   @parent = parent
 end

 def from_csv(data)
   InvoiceItemRepo.new(data)
 end

 def all
   return invoice_items.values
 end

 def find_by_id(id)
   invoice_items[id]
 end

 def find_all_by_item_id(id)
   invoice_items.values.find_all do |invoice_item|
     invoice_item.item_id == id
   end
 end

 def total(keys)
   invoice_items.values.reduce({}) do |result, invoice_item|
     if result.has_key?(invoice_item.invoice_id)
       result[invoice_item.invoice_id] += invoice_item.total
       result
     else
       result.merge({invoice_item.invoice_id => invoice_item.total})
     end
   end
 end

 def find_all_by_invoice_id(id)
   invoice_items.values.find_all do |invoice_item|
     invoice_item.invoice_id == id
   end
 end
end
