defmodule Conduit.Blog.Supervisor do
  use Supervisor

  alias Conduit.Blog
  alias Conduit.Blog.BlogSupervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([
      Blog.Projectors.Article,
      Blog.Projectors.Tag,
      Blog.Workflows.CreateAuthorFromUser,
      BlogSupervisor
    ], strategy: :one_for_one)
  end
end
