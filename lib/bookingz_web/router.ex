defmodule BookingzWeb.Router do
  use BookingzWeb, :router

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

  scope "/", BookingzWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BookingzWeb do
  #   pipe_through :api
  # end

  scope "/api", BookingzWeb do
    pipe_through :api
      post "/book-loans", BookLoanApiController, :getBookLoans
      post "/book-loans/extend", BookLoanApiController, :extendBookLoan
  end

end
