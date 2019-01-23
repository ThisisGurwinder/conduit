defmodule Conduit.Blog.BlogSupervisor do
  use Commanded.Event.Handler,
    name: "BlogHandler",
    consistency: :strong

  alias Conduit.Accounts.Events.UserRegistered
  alias Conduit.Blog.Commands.{FavoriteArticle,FollowAuthor,CommentOnArticle,CreateAuthor,DeleteComment,FavoriteArticle,PublishArticle,UnfavoriteArticle,UnfollowAuthor}
  alias Conduit.{Repo,Router}

  import Ecto
  def handle(%UserRegistered{} = x, _metadata) do
    x = create_author(%{user_uuid: Ecto.UUID.generate(), username: "jakew"})
    :ok
  end

  def create_author(%{user_uuid: uuid} = attrs) do
    create_author =
      attrs
      |> CreateAuthor.new()
      |> CreateAuthor.assign_uuid(uuid)

    with rsult <- Router.dispatch(create_author, consistency: :strong) do
      IO.inspect({:DONE_BLOG, rsult})
      :ok
    else
      reply -> reply
    end
  end
end
