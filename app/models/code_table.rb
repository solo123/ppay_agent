class CodeTable < ActiveRecord::Base
  def self.find_code(cat_name, code_name)
    cat = CodeTable.find_or_create_by(name: cat_name)
    CodeTable.find_or_create_by(parent_id: cat.id, name: code_name)
  end
  def self.find_prov(prov)
    cat = CodeTable.find_or_create_by(name: 'province')
    CodeTable.find_or_create_by(parent_id: cat.id, name: prov)
  end
  def self.find_city(prov_id, city)
    CodeTable.find_or_create_by(parent_id: prov_id, name: city)
  end
end
