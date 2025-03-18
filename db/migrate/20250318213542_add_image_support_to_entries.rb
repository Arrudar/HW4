class AddImageSupportToEntries < ActiveRecord::Migration[7.1]
  def change
      add_column :entries, :image, :string
  end
end
