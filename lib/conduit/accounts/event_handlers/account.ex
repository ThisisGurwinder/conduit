defmodule Conduit.Accounts.AccountSupervisor do
  use Commanded.Event.Handler,
    name: "AccountHandler",
    consistency: :strong

  alias Conduit.Accounts
  alias Conduit.Accounts.Events.UserRegistered
  alias Conduit.Accounts.Commands.RegisterUser

  def handle(%UserRegistered{} = x, _metadata) do
    params = %Conduit.Accounts.Commands.RegisterUser{username: "BLAAAA", email: "BLAAA@gmail.com"}
    result = Accounts.register_user(params)
    :ok
  end
end
