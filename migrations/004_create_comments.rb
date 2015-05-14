Sequel.migration do
  up do
    create_table(:comments) do
      primary_key :id

      String :text

      foreign_key :content_id
      foreign_key :user_id
    end
  end

  down do
    drop_table(:comments)
  end
end