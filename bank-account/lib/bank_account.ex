defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid
  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    Agent.start_link(fn -> %{balance: 0, status: "active"} end)
    |> elem(1)
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.update(account, fn (state) -> %{balance: state.balance, status: "disabled"} end)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    case account_status(account) do
      "active" -> Agent.get(account, &(&1)) |> Map.get(:balance)
      _ -> {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    case account_status(account) do
      "active" -> Agent.update(account, fn (state) -> %{balance: state.balance + amount, status: state.status} end)
      _ -> {:error, :account_closed}
    end

  end

  def account_status(account) do
    Agent.get(account, &(&1))
    |> Map.get(:status)
  end
end
