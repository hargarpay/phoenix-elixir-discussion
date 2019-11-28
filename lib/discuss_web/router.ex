defmodule DiscussWeb.Router do
  use DiscussWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DiscussWeb do
    pipe_through :browser

    # get "/", PageController, :index

    # get "/topics", TopicController, :index

    # get "/topic/new", TopicController, :new

    # post "/topics", TopicController, :create

    # get "/topic/:id/edit", TopicController, :edit

    # put "/topic/:id", TopicController, :update

    # delete "/topic/:id/delete", TopicController, :delete

    resources "/", TopicController
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiscussWeb do
  #   pipe_through :api
  # end
end
