class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :code
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
