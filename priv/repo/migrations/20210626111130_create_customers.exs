defmodule Customer.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string
      add :email, :string
      add :taxId, :string
      add :legalType, :integer

      timestamps()
    end

  end
end
