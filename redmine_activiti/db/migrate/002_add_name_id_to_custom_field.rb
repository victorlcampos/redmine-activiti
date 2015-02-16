class AddNameIdToCustomField < ActiveRecord::Migration
  def change
    add_column :custom_fields, :method_name, :string
  end
end