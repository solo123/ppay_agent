class CodeTable < ActiveRecord::Base
  belongs_to :parent, class_name: 'CodeTable'
  scope :top_level, -> {where(parent: nil)}

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
  def self.childs(parent)
    if parent.to_i > 0
      self.where(parent: parent)
    else
      p = self.where(name: parent)
      if p
        self.where(parent: p)
      else
        []
      end
    end
  end
  def childs
    CodeTable.childs(self)
  end
  def to_i
    self.id
  end

end
