Sequel.migration do
  up do
    create_table(:contents) do
      primary_key :id

      String :body
      String :title

      foreign_key :discussion_id
      foreign_key :user_id
    end
  end

  down do
    drop_table(:contents)
  end
end