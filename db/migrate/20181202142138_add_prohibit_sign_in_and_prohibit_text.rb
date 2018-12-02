class AddProhibitSignInAndProhibitText < ActiveRecord::Migration
  def up
    add_column :reservations, :prohibit_sign_in, :boolean, default: false
    add_column :reservations, :prohibit_sign_in_text, :string, default: ""
  end

  def down
    remove_column :reservations, :prohibit_sign_in, :boolean
    remove_column :reservations, :prohibit_sign_in_text, :string
  end
end
