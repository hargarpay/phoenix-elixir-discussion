defmodule DiscussWeb.Topic do
  use DiscussWeb, :model

  schema "topics" do
    field :title, :string
  end

  @doc false
  def changeset(%DiscussWeb.Topic{} = struct, params) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
