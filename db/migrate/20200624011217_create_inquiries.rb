class CreateInquiries < ActiveRecord::Migration[6.0]
  def change
    create_table :inquiries do |t|
      t.string :email
      t.string :name
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
