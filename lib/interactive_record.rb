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

end
