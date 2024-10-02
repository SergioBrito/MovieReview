class CreateReviewRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :review_ratings do |t|
      t.references :review, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :score, null: false

      t.timestamps
    end

    add_index :review_ratings, [:review_id, :category_id], unique: true
  end
end
