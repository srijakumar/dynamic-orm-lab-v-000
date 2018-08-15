require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def self.table_name
    "#{self.to_s.downcase}s"
  end

  def self.column_names
    sql = "pragma table_info('#{table_name}')"

    table = DB[:conn].execute(sql)

    column_names=[]
    table.each do|row|
      column_names << row["name"]
    end
    column_names.compact
  end

  def initialize(options={})
    options.each do |property, value|
      self.send("#{property}=", value)
    end
  end

  def table_name_for_insert
    self.class.table_name
  end

  def values_for_insert
  values = []
  self.class.column_names.each do |col_name|
    values << "'#{send(col_name)}'" unless send(col_name).nil?
  end
  values.join(", ")
end

end
