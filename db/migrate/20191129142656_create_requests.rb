class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :request_month, nil: false, default: "0"
      t.string :confirmation, nil: false, default: "0"

      t.timestamps
    end
  end
end
