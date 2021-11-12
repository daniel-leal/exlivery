defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.User
  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      cpf = "78945612300"

      {:ok, cpf: cpf}
    end

    test "when the user is found, returns the user", %{cpf: cpf} do
      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get("78945612300")

      expected_response =
        {:ok,
         %User{
           address: "Rua das bananeiras, 35",
           age: 27,
           cpf: "78945612300",
           email: "daniel@banana.com",
           name: "Daniel"
         }}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("0000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
