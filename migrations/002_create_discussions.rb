Sequel.migration do
  up do
    create_table(:discussions) do
      primary_key :id

      String :title
      String :timestamp

      foreign_key :user_id
    end
  end

  down do
    drop_table(:discussions)
  end
end