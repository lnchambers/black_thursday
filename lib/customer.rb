require 'time'

class Customer
 attr_reader  :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository


  def initialize(data, repository)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @created_at = created_at
    @updated_at = updated_at
    @repository = repository
  end

end
