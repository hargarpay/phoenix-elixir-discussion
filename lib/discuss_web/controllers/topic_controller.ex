defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias DiscussWeb.Topic

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end
  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn,  "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
       {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic has been created")
        |> redirect(to: Routes.topic_path(conn, :index))
       {:error, changeset} ->
        render(conn,  "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic, %{})

    cond do
      topic == nil ->
              conn
              |> put_flash(:error, "Topic can not be found")
              |>redirect(to: Routes.topic_path(conn, :index))
      topic != nil->
         render(conn,  "edit.html", changeset: changeset, topic: topic)
    end
  end

  def update(conn, %{"topic" => topic, "id" => topic_id}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic has been updated")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render(conn,  "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic, %{})

    cond do
      topic == nil ->
              conn
              |> put_flash(:error, "There was an issue deleting Topic")
              |>redirect(to: Routes.topic_path(conn, :index))
      topic != nil->
        case Repo.delete(changeset)do
          {:ok, _topic} ->
            conn
            |> put_flash(:info, "Topic has been deleted")
            |> redirect(to: Routes.topic_path(conn, :index))
          {:error, changeset} ->
            conn
              |> put_flash(:error, "There was an issue deleting Topic")
              |>redirect(to: Routes.topic_path(conn, :index))
        end
         render(conn,  "edit.html", changeset: changeset, topic: topic)
    end
  end


end
