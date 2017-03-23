defmodule Slackjack.Bot do
  @moduledoc """
  Get the events we want from slack.

  ### Examples

      iex> {:ok, pid} = Slack.Bot.start_link(Slackjack.Bot, [], Application.get_env(:slackjack, :key))

  """

  use Slack

  alias Slackjack.Logs.Message
  alias Slackjack.Repo
  alias Slackjack.Logs.User  

  @test_channel Application.get_env(:slackjack, :test_channel)

  @doc """
  Start the bot connection to slack.
  """
  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

   @doc """
  A channel was archived.
  see: https://api.slack.com/events/channel_archive
  """
  def handle_event(event = %{type: "channel_archive"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was created.
  see: https://api.slack.com/events/channel_created
  """
  def handle_event(event = %{type: "channel_created"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was deleted.
  see: https://api.slack.com/events/channel_deleted
  """
  def handle_event(event = %{type: "channel_deleted"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A team member left the channel.
  see: https://api.slack.com/events/channel_leave
  """
  def handle_event(event = %{subtype: "channel_leave"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was renamed.
  see: https://api.slack.com/events/channel_rename
  """
  def handle_event(event = %{type: "channel_rename"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was unarchived.
  see: https://api.slack.com/events/channel_unarchive
  """
  def handle_event(event = %{type: "channel_unarchive"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A message was edited.
  see: https://api.slack.com/events/message
  """
  def handle_event(%{subtype: "message_changed", message: message}, slack, state) do
    changeset =
      Message
      |> Repo.get(message.id)
      |> Message.changeset(message)
    
    case Repo.update(changeset) do
      {:ok, _message} -> {:ok, state}
      {:error, _changeset} ->
        send_message("There was an error updating DB.", @test_channel, slack)
        {:ok, state}
    end
  end

  @doc """
  A message was deleted from a channel.
  see: https://api.slack.com/events/message
  """
  def handle_event(%{subtype: "message_deleted", message: message}, slack, state) do
    message = Repo.get(Message, message.id)
    
    case Repo.delete(message) do
      {:ok, _message} -> {:ok, state}
      {:error, _changeset} ->
        send_message("There was an error deleting from the DB.", @test_channel, slack)
        {:ok, state}
    end
  end

  @doc """
  A message was sent to a channel.
  see: https://api.slack.com/events/message
  """
  def handle_event(%{type: "message", message: message}, slack, state) do
    changeset = Message.changeset(%Message{}, message)
    
    case Repo.insert(changeset) do
      {:ok, _message} -> {:ok, state}
      {:error, _changeset} ->
        send_message("There was an error inserting into DB.", @test_channel, slack)
        {:ok, state}
    end
  end

  @doc """
  A pin was added to a channel.
  see: https://api.slack.com/events/pin_added
  """
  def handle_event(event = %{type: "pin_added"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A pin was removed from a channel.
  see: https://api.slack.com/events/pin_removed
  """
  def handle_event(event = %{type: "pin_removed"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A new team member joined.
  see: https://api.slack.com/events/team_join
  """
  def handle_event(event = %{type: "team_join"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A team member's data has changed.
  see: https://api.slack.com/events/user_change
  """
  def handle_event(%{type: "user_change", user: user}, slack, state) do
    changeset =
      User
      |> Repo.get(user.id)
      |> User.changeset(user)
    
    case Repo.update(changeset) do
      {:ok, _user} -> {:ok, state}
      {:error, _changeset} ->
        send_message("There was an error updating DB.", @test_channel, slack)
        {:ok, state}
    end
  end

  @doc """
  Do nothing for events we don't care about.
  """
  def handle_event(_event, _slack, state), do: {:ok, state}

  @doc """
  Send a message or something.
  """
  def handle_info({:message, text, channel}, slack, state) do
    IO.puts "Sending your message, captain!"
    send_message(text, channel, slack)
    {:ok, state}
  end
  def handle_info(_, _, state), do: {:ok, state}

end
