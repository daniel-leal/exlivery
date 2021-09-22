defmodule Exlivery.Users.User do
  @keys [:name, :email, :cpf, :age, :address]
  @enforce_keys @keys

  defstruct [:address, :name, :email, :cpf, :age]

  def build(address, name, email, cpf, age) when age >= 18 do
    {:ok,
     %__MODULE__{
       address: address,
       name: name,
       email: email,
       cpf: cpf,
       age: age
     }}
  end

  def build(_address, _name, _email, _cpf, _age), do: {:error, "Invalid parameters"}
end
