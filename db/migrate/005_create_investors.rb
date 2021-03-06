class CreateInvestors< ActiveRecord::Migration
  def change
    create_table :investors do |i|
      i.string :stock_code
      i.string :stock_name
      i.string :stock_industry
      i.string :stock_type
      i.string :name
      i.string :position
      i.float :reward
      i.integer :shares_count_beginning
      i.integer :shares_count_end
      i.integer :shares_count_change
      i.integer :shares_value_beginning
      i.integer :shares_value_end
      i.integer :shares_value_change
      i.float :ratio_to_net_value
    end
    add_index :investors, [:stock_code, :name], :unique => true

  end
end