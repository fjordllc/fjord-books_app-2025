class CreateReportMentions < ActiveRecord::Migration[8.0]
  def change
    create_table :report_mentions do |t|
      t.references :mentioning, null: false, foreign_key: { to_table: 'reports' }, index: false
      t.references :mentioned, null: false, foreign_key: { to_table: 'reports' }

      t.timestamps
    end
    add_index :report_mentions, %i[mentioning_id mentioned_id], unique: true
  end
end
