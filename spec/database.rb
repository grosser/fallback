require 'active_record'

# connect
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)

# create tables
ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.string :name
    t.string :title
    t.string :description
    t.text :detailed_description
  end

  create_table :shops do |t|
    t.string :name
    t.string :title
    t.string :description
  end
end
