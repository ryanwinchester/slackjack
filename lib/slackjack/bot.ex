defmodule Slackjack.Bot do
  @moduledoc """
  Get the events we want from slack.

  ### Examples

      iex> {:ok, pid} = Slack.Bot.start_link(Slackjack.Bot, [], Application.get_env(:slackjack, :key))

  """

  use Slack

  alias Slackjack.Logs.Channel
  alias Slackjack.Logs.Message
  alias Slackjack.Logs.User  
  alias Slackjack.Repo

  @test_channel Application.get_env(:slackjack, :test_channel)

  @doc """
  Start the bot connection to slack.
  """
  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    update_channels()
    update_users()
    {:ok, state}
  end

   @doc """
  A channel was archived.
  see: https://api.slack.com/events/channel_archive
  """
  def handle_event(_event = %{type: "channel_archive"}, _slack, state) do
    # IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was created.
  see: https://api.slack.com/events/channel_created
  """
  def handle_event(_event = %{type: "channel_created"}, _slack, state) do
    # IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was deleted.
  see: https://api.slack.com/events/channel_deleted
  """
  def handle_event(_event = %{type: "channel_deleted"}, _slack, state) do
    # IO.inspect event
    {:ok, state}
  end

  @doc """
  A team member left the channel.
  see: https://api.slack.com/events/channel_leave
  """
  def handle_event(_event = %{subtype: "channel_leave"}, _slack, state) do
    # IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was renamed.
  see: https://api.slack.com/events/channel_rename
  """
  def handle_event(_event = %{type: "channel_rename"}, _slack, state) do
    # IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was unarchived.
  see: https://api.slack.com/events/channel_unarchive
  """
  def handle_event(_event = %{type: "channel_unarchive"}, _slack, state) do
    {:ok, state}
  end

  @doc """
  Ignore message edit attachments.
  """
  def handle_event(%{subtype: "message_changed", message: %{attachments: _attachments}}, _slack, state) do
    {:ok, state}
  end

  @doc """
  A message was edited.
  see: https://api.slack.com/events/message
  """
  def handle_event(event = %{subtype: "message_changed", channel: "C" <> _}, slack, state) do
    changeset =
      Message
      |> Repo.get!(event.previous_message.ts)
      |> Message.changeset(event.message)
    
    case Repo.update(changeset) do
      {:ok, message} -> send_success(message, slack, state)
      {:error, changeset} -> send_error(changeset, slack, state)
    end
  end

  @doc """
  A message was deleted from a channel.
  see: https://api.slack.com/events/message
  """
  def handle_event(message = %{subtype: "message_deleted", channel: "C" <> _}, slack, state) do
    message = Repo.get(Message, message.deleted_ts)
    
    case Repo.delete(message) do
      {:ok, message} -> send_success(message, slack, state)
      {:error, changeset} -> send_error(changeset, slack, state)
    end
  end

  @doc """
  A message was a `/me` action.
  """
  def handle_event(message = %{subtype: "me_message", channel: "C" <> _}, slack, state) do
    message
    |> Map.delete(:subtype)
    |> Map.put(:text, "/me #{message.text}")
    |> handle_event(slack, state)
  end

  @doc """
  A message was sent to a channel.
  see: https://api.slack.com/events/message
  """
  def handle_event(message = %{type: "message", channel: "C" <> _}, slack, state) do
    changeset = Message.create_changeset(%Message{}, message)
    
    case Repo.insert(changeset) do
      {:ok, message} -> send_success(message, slack, state)
      {:error, changeset} -> send_error(changeset, slack, state)
    end
  end

  @doc """
  A pin was added to a channel.
  see: https://api.slack.com/events/pin_added
  """
  def handle_event(_event = %{type: "pin_added"}, _slack, state) do
    # IO.inspect event
    {:ok, state}
  end

  @doc """
  A pin was removed from a channel.
  see: https://api.slack.com/events/pin_removed
  """
  def handle_event(_event = %{type: "pin_removed"}, _slack, state) do
    # IO.inspect event
    {:ok, state}
  end

  @doc """
  A new team member joined.
  see: https://api.slack.com/events/team_join
  """
  def handle_event(_event = %{type: "team_join"}, _slack, state) do
    # IO.inspect event
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
      {:ok, user} -> send_success(user, slack, state)
      {:error, changeset} -> send_error(changeset, slack, state)
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

  defp send_success(_resource, _slack, state) do
    {:ok, state}
  end

  defp send_error(changeset, slack, state) do
    errors = errors_to_string(changeset)
    send_message(errors, @test_channel, slack)
    {:ok, state}
  end

  defp errors_to_string(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
    |> Enum.map(fn {field, errors} ->
      "`#{to_string(field)}`: " <> Enum.join(errors, ", ")
    end)
    |> Enum.join("\n")
  end

  defp update_channels() do
    slack_channels = Slack.Web.Channels.list()

    Enum.map(slack_channels["channels"], fn slack_channel ->
      slack_channel =
       slack_channel
       |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
       |> Enum.into(%{})

      channel = Repo.get(Channel, slack_channel.id)

      changeset =
        case channel do
          nil -> Channel.changeset(%Channel{}, slack_channel)
          _ -> Channel.changeset(channel, slack_channel)
        end
        
      Repo.insert_or_update!(changeset)
    end)
  end

  defp update_users() do
    slack_users = Slack.Web.Users.list()

    Enum.map(slack_users["members"], fn slack_user ->
      slack_user =
       slack_user
       |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
       |> Enum.into(%{})

      user = Repo.get(User, slack_user.id)

      changeset =
        case user do
          nil -> User.changeset(%User{}, slack_user)
          _ -> User.changeset(user, slack_user)
        end
        
      Repo.insert_or_update!(changeset)
    end)
  end

end
